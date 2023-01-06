//
//  main.swift
//  [baekjoon]4485
//
//  Created by 양승현 on 2023/01/06.
//

import Foundation

struct Heap<T> where T: Comparable {
    private var list = [T]()
    private let isLeftSmall: (T,T) -> Bool
    var isEmpty: Bool {
        return list.isEmpty
    }
    var count: Int {
        return list.count
    }
    init(isLeftSmall: @escaping (T, T) -> Bool) {
        self.isLeftSmall = isLeftSmall
    }
    init() {
        self.init(isLeftSmall: <)
    }
}
extension Heap {
    mutating func insert(_ element: T) {
        var idx = list.count
        list.append(element)
        while idx > 0 && isLeftSmall(list[idx], list[(idx-1)/2]) {
            list.swapAt(idx, (idx-1)/2)
            idx = (idx-1)/2
        }
    }
    mutating func delete() -> T? {
        guard !isEmpty else {
            return nil
        }
        guard count != 1 else {
            return list.removeFirst()
        }
        let element = list.first!
        var idx = 0
        list.swapAt(idx, list.count-1)
        _ = list.removeLast()
        while idx < list.count {
            let (left,right) = (idx*2+1,idx*2+2)
            if right < count {
                if isLeftSmall(list[left],list[right]) && isLeftSmall(list[left], list[idx]) {
                    list.swapAt(left, idx)
                    idx = left
                } else if isLeftSmall(list[right], list[idx]) {
                    list.swapAt(right, idx)
                    idx = right
                }else {
                    break
                }
            } else if left < count {
                if isLeftSmall(list[left], list[idx]) {
                    list.swapAt(left, idx)
                    idx = left
                } else {
                    break
                }
            } else {
                break
            }
        }
        return element
    }
}

typealias Point = (x:Int,y:Int)
struct Node {
    let point: Point
    let cost: Int
    var x: Int {
        return point.x
    }
    var y: Int {
        return point.y
    }
}
extension Node: Comparable {
    static func <(lhs: Node, rhs: Node) -> Bool {
        return lhs.cost < rhs.cost
    }
    static func ==(lhs: Node, rhs: Node) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
let Direction = [(-1,0),(1,0),(0,1),(0,-1)]
func isOutOfBound(point: Point, n: Int) -> Bool {
    return point.x < 0 || point.x > n - 1 || point.y < 0 || point.y > n - 1
}
//항상 visit에 처음꺼 더해주기
func dijkstra(map : inout [[Int]],visited : inout [[Int]], n: Int) {
    var priority = Heap<Node>()
    priority.insert(Node(point: (0,0), cost: 0))
    visited[0][0] = 0
    while !priority.isEmpty {
        guard let curNode = priority.delete() else {
            return
        }
        if visited[curNode.y][curNode.x] < curNode.cost {
            continue
        }
        for (dx,dy) in Direction {
            let (nx,ny) = (curNode.x+dx,curNode.y+dy)
            if isOutOfBound(point: (nx,ny), n: n) { continue }
            if visited[ny][nx] > curNode.cost + map[ny][nx] {
                visited[ny][nx] = curNode.cost + map[ny][nx]
                priority.insert(Node(point: (nx,ny), cost: visited[ny][nx]))
            }
        }
    }
}

//MARK: - Properties
func solution() {
    var idx = 1
    while true {
        let n = Int(readLine()!)!
        if n == 0 { break }
        var map = Array(repeating: [Int](), count: n)
        var visited = Array(repeating: Array(repeating:Int.max, count:n), count: n)
        (0..<n).forEach{ i in
            map[i] = readLine()!.split{$0==" "}.map{Int(String($0))!}
        }
        dijkstra(map: &map, visited: &visited, n: n)
        print("Problem \(idx): \(map[0][0]+visited[n-1][n-1])")
        idx += 1
    }
}

solution()
