//
//  main.swift
//  [baekjoon]1504
//
//  Created by 양승현 on 2023/01/09.
//

import Foundation

// https://dev-with-precious-dreams.tistory.com/161

struct Heap<T> where T: Comparable {
    private var list = [T]()
    let isLeftSmall: (T,T)->Bool
    init(isLeftSmall: @escaping (T, T) -> Bool) {
        self.isLeftSmall = isLeftSmall
    }
    init(){
        self.init(isLeftSmall: <)
    }
}
extension Heap {
    var count: Int {
        return list.count
    }
    var isEmpty: Bool {
        return list.isEmpty
    }
    var peek: T? {
        return list.first
    }
}
extension Heap {
    mutating func insert(_ element: T) {
        var idx = list.count
        list.append(element)
        while idx > 0 && isLeftSmall(list[idx],list[(idx-1)/2]) {
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
        var idx = 0
        let element = list.first!
        list.swapAt(idx, count-1)
        _ = list.popLast()
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
    let vertex: Int
    let cost: Int
    
}
extension Node: Comparable {
    static func <(lhs: Node, rhs: Node) -> Bool {
        return lhs.cost < rhs.cost
    }
    static func ==(lhs: Node, rhs: Node) -> Bool {
        return lhs.vertex == rhs.vertex
    }
}

//MARK: - Properties
let ve = readLine()!.split{$0==" "}.map{Int(String($0))!}
let nodeCount = ve[0]
let edgeCount = ve[1]
var graph = Array(repeating:[Node](),count:nodeCount)
(0..<edgeCount).forEach { _ in
    let input = readLine()!.split{$0==" "}.map{Int(String($0))!}
    let (s,e,c) = (input[0] - 1,input[1] - 1,input[2])
    graph[s].append(Node(vertex: e, cost: c))
    graph[e].append(Node(vertex: s, cost: c))
}
let input = readLine()!.split{$0==" "}.map{Int(String($0))!}
let (v1,v2) = (input[0]-1,input[1]-1)

func dijkstra(_ start: Int, visited: inout [Int]) {
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
var (sToV1, sToV2, v1ToV2, v1ToN, v2ToN) = (-1,-1,-1,-1,-1)
var startList = [0,v1,v2]
for i in 0..<startList.count {
    var visited = Array(repeating: Int.max, count: nodeCount)
    dijkstra(startList[i], visited: &visited)
    switch i {
    case 0:
        sToV1 = visited[v1]
        sToV2 = visited[v2]
    case 1:
        v1ToV2 = visited[v2]
        v1ToN = visited[nodeCount-1]
    case 2:
        v2ToN = visited[nodeCount-1]
    default:
        break
    }
}
var res = Int.max
if sToV1 == Int.max || v1ToV2 == Int.max || v2ToN == Int.max {
    res = Int.max
} else {
    res = min(res,sToV1+v1ToV2+v2ToN)
}
if sToV2 == Int.max || v1ToV2 == Int.max || v1ToN == Int.max {
    res = Int.max
} else {
    res = min(res,sToV2+v1ToV2+v1ToN)
}
print(res == Int.max ? -1 : res)

