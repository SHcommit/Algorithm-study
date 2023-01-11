//
//  main.swift
//  [baekjoon]11779
//
//  Created by 양승현 on 2023/01/11.
//

import Foundation
// https://dev-with-precious-dreams.tistory.com/167
struct Heap<T> where T: Comparable {
    private var list = [T]()
    var isLeftSmall: (T,T) -> Bool
    init(isLeftSmall: @escaping (T,T)->Bool) {
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
    var peek: T? {
        return list.first
    }
    var count: Int {
        return list.count
    }
}
extension Heap {
    mutating func insert(_ element: T) {
        var idx = count
        list.append(element)
        while idx>0 && isLeftSmall(list[idx],list[(idx-1)/2]) {
            list.swapAt(idx, (idx-1)/2)
            idx = (idx-1)/2
        }
    }
    mutating func delete() -> T? {
        guard !isEmpty else { return nil }
        guard count != 1 else { return list.removeFirst() }
        let element = list.first!
        var idx = 0
        list.swapAt(idx, count-1)
        _ = list.removeLast()
        while idx < count {
            let (left,right) = (idx*2+1,idx*2+2)
            if right < count {
                if isLeftSmall(list[left],list[right]) && isLeftSmall(list[left],list[idx]) {
                    list.swapAt(left, idx)
                    idx = left
                } else if isLeftSmall(list[right],list[idx]) {
                    list.swapAt(right, idx)
                    idx = right
                } else {
                    break
                }
            } else if left < count {
                if isLeftSmall(list[left],list[idx]) {
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
struct Node {
    var vertex: Int
    var cost: Int
}
extension Node: Comparable {
    static func <(lhs: Node, rhs: Node) -> Bool {
        return lhs.cost < rhs.cost
    }
    static func ==(lhs: Node, rhs: Node) -> Bool {
        return lhs.vertex == rhs.vertex
    }
}
var nCnt = Int(readLine()!)!
var graph = Array(repeating: [Node](), count: nCnt)
(0..<Int(readLine()!)!).forEach { _ in
    let input = readLine()!.split{$0==" "}.map{Int(String($0))!}
    let (s,e,c) = (input[0]-1,input[1]-1,input[2])
    graph[s].append(Node(vertex: e, cost: c))
}
var se = readLine()!.split{$0==" "}.map{Int(String($0))!}
let (start, end) = (se[0]-1,se[1]-1)
var seq = Array(repeating: 0, count: nCnt)
var visited = Array(repeating:Int.max, count: nCnt)

func dijkstra() {
    var priority = Heap<Node>()
    priority.insert(Node(vertex: start, cost: 0))
    visited[start] = 0
    while !priority.isEmpty {
        guard let curNode = priority.delete() else {
            break
        }
        if visited[curNode.vertex] < curNode.cost {
            continue
        }
        for node in graph[curNode.vertex] {
            if visited[node.vertex] > visited[curNode.vertex] + node.cost {
                visited[node.vertex] = visited[curNode.vertex] + node.cost
                seq[node.vertex] = curNode.vertex
                priority.insert(Node(vertex: node.vertex, cost: visited[node.vertex]))
            }
        }
    }
}

dijkstra()
var res = ""
res += "\(visited[end])\n"
var ans = [Int]()
ans.append(end+1)
var vertex = end
while vertex != start {
    vertex = seq[vertex]
    ans.insert(vertex+1, at: 0)
}
res += "\(ans.count)\n"
res += ans.reduce(""){"\($0)\($1) "}
print(res)
