//
//  main.swift
//  [baekjoon]1261
//
//  Created by 양승현 on 2023/01/08.
//

/*
    힙을 연습 중 인데 한 6분걸린것 같다. 계속하면 단축 될거 같다.
    벽부수기 문제인데 예전에는 그냥 배열에 좌표, 부순 벽 횟수를 썼었는데 이번엔 힙을 적용했다.
    여태까지 푼 문제는 edge를 지나갈 때 cost가 있었는데 이건 그냥 벽을 부순 횟수를 기록해야해서
    힙에 저장할 때 벽을 부순 횟수를 저장하는 방식으로 갔다. 근데 65%에서 시간초과가 나서 방문할 곳이 1인 경우는 현재 벽 부순 횟수 + 1 이면 그냥 스킵하도록 추가 구현 했더니 통과했다. 다른 분들이 풀은 것을 봤는데 힙 말고 덱을 썼다. 덱도 연습해야겠다.
 */

import Foundation

//MARK: - Model
struct Heap<T> where T: Comparable {
    private var list = [T]()
    private let isLeftSmall: (T,T) -> Bool
    init(isLeftSmall: @escaping (T, T) -> Bool) {
        self.isLeftSmall = isLeftSmall
    }
    init() {
        self.init(isLeftSmall: <)
    }
}
extension Heap {
    var isEmpty: Bool {
        return list.isEmpty
    }
    var count: Int {
        return list.count
    }
}
extension Heap {
    mutating func insert(_ element: T) {
        var idx = list.count
        list.append(element)
        while idx < list.count && isLeftSmall(list[idx],list[(idx-1)/2]) {
            list.swapAt(idx, (idx-1)/2)
            idx = (idx-1)/2
        }
    }
    mutating func delete() -> T? {
        guard !isEmpty else {
            return nil
        }
        guard count != 1 else {
            return list.popLast()
        }
        let element = list.first!
        var idx = 0
        list.swapAt(idx, count - 1)
        _ = list.removeLast()
        while idx < count {
            let (left,right) = (idx*2+1,idx*2+2)
            if right < list.count {
                if isLeftSmall(list[left],list[right]) && isLeftSmall(list[left], list[idx]) {
                    list.swapAt(left, idx)
                    idx = left
                } else if isLeftSmall(list[right],list[idx]) {
                    list.swapAt(right, idx)
                    idx = right
                } else {
                    break
                }
            } else if left < list.count {
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
    private var point: Point
    var breakCnt: Int
    init(point: Point, breakCnt: Int) {
        self.point = point
        self.breakCnt = breakCnt
    }
    var x: Int {
        return point.x
    }
    var y: Int {
        return point.y
    }
}
extension Node: Comparable {
    static func <(lhs:Node, rhs:Node) -> Bool {
        return lhs.breakCnt < rhs.breakCnt
    }
    static func ==(lhs:Node,rhs:Node) -> Bool {
        return lhs.point == rhs.point
    }
}
let Direction = [(-1,0),(1,0),(0,1),(0,-1)]

//MARK: - Properties
var (width, height) = (0,0)
var map = [[Int]]()
var visited = [[Int]]()
var start: Point = (-1,-1)
var end: Point = (-1,-1)

//MARK: - Helpers
func input() {
    let wh = readLine()!.split{$0==" "}.map{Int(String($0))!}
    width = wh[0]
    height = wh[1]
    map = Array(repeating:[Int](),count:height)
    visited = Array(repeating:Array(repeating: Int.max,count: width), count:height)
    (0..<height).forEach{ i in
        let input = readLine()!.map{Int(String($0))!}
        map[i] = input
    }
    start = (0,0)
    end = (width-1,height-1)
}

func isOutOfBounds(point:Point) -> Bool {
    return point.x < 0 || point.x > width-1 || point.y < 0 || point.y > height-1
}

func dijkstra() {
    var priority = Heap<Node>()
    priority.insert(Node(point: start, breakCnt: 0))
    visited[start.y][start.x] = 0
    while !priority.isEmpty {
        guard let curNode = priority.delete() else {
            break
        }
        if curNode.breakCnt > visited[curNode.y][curNode.x] {
            continue
        }
        for (dx,dy) in Direction {
            let (nx,ny) = (curNode.x+dx,curNode.y+dy)
            if isOutOfBounds(point: (nx,ny)) { continue }
            if visited[ny][nx] > visited[curNode.y][curNode.x] {
                if map[ny][nx] == 0 {
                    visited[ny][nx] = visited[curNode.y][curNode.x]
                    priority.insert(Node(point: (nx,ny), breakCnt: visited[ny][nx]))
                } else if map[ny][nx] == 1 && visited[ny][nx] > curNode.breakCnt + 1 {
                    visited[ny][nx] = visited[curNode.y][curNode.x] + 1
                    priority.insert(Node(point: (nx,ny), breakCnt: visited[ny][nx]))
                }
            }
        }
    }
}

func solution() {
    input()
    dijkstra()
    print(visited[end.y][end.x])
}

solution()
