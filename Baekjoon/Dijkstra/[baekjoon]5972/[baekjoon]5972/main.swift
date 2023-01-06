//
//  main.swift
//  [baekjoon]5972
//
//  Created by 양승현 on 2023/01/06.
//

import Foundation

struct Heap<T> where T: Comparable{
    private var list = [T]()
    private let compare: (T,T) -> Bool
    var isEmpty: Bool {
        return list.isEmpty
    }
    init(compare: @escaping (T,T) -> Bool) {
        self.compare = compare
    }
    init() {
        self.init(compare: <)
    }
}
extension Heap {
    mutating func insert(_ element: T) {
        var idx = list.count
        list.append(element)
        while idx > 0 && compare(list[idx] ,list[(idx-1)/2]) {
            list.swapAt((idx-1)/2, idx)
            idx = (idx-1)/2
        }
    }
    mutating func delete() -> T? {
        guard !list.isEmpty else {
            return nil
        }
        guard list.count != 1 else {
            return list.removeFirst()
        }
        let element = list.first!
        var idx = 0
        list.swapAt(idx, list.count - 1)
        _ = list.popLast()
        while idx < list.count {
            let (left,right) = (idx*2+1,idx*2+2)
            if right < list.count {
                if compare(list[left],list[right]) && compare(list[left],list[idx]) {
                    list.swapAt(left, idx)
                    idx = left
                } else if compare(list[right], list[idx]) {
                    list.swapAt(right, idx)
                    idx = right
                } else {
                    break
                }
            } else if left < list.count {
                if compare(list[left], list[idx]) {
                    list.swapAt(left, idx)
                    idx = left
                }else {
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
}

//MARK: - Properties
var NM = readLine()!.split{$0==" "}.map{Int(String($0))!}
let (vCnt, eCnt) = (NM[0], NM[1])
var graph = Array(repeating: [Node](), count: vCnt)
var visited = Array(repeating:Int.max, count:vCnt)

func input() {
    (0..<eCnt).forEach{ _ in
        let input = readLine()!.split{$0==" "}.map{Int(String($0))!}
        let (s,e,c) = (input[0]-1,input[1]-1,input[2])
        graph[s].append(Node(vertex: e, cost: c))
        graph[e].append(Node(vertex: s, cost: c))
    }
}

func dijkstra(_ start: Int) {
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
                priority.insert(Node(vertex: node.vertex, cost: visited[node.vertex]))
            }
        }
    }
}

func solution() {
    input()
    dijkstra(0)
    print(visited[vCnt-1])
}

solution()
