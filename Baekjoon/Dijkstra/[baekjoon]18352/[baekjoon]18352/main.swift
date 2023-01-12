//
//  main.swift
//  [baekjoon]18352
//
//  Created by 양승현 on 2023/01/12.
//

import Foundation

/*
    문제 요약:
    
    1~N 까지 단방향 도로.
 
    - 모든 도로 거리 1
    
    특정 도시 x로부터 출발해서 도달할 수 있는 모든 도시 중에서 최단 거리가 정확히 k인 모든 도시들의 번호 출력!
    자기자신은 0
    
    Swift는 좀 느리다.. 문제
 */

struct Heap<T> where T: Comparable {
    private var list = [T]()
    private var isLeftSmall: (T,T) -> Bool
    init(isLeftSmall: @escaping (T,T)->Bool) {
        self.isLeftSmall = isLeftSmall
    }
    init() {
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
}

extension Heap {
    mutating func insert(_ element: T) {
        var idx = count
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
        guard 1 != count else {
            return list.removeFirst()
        }
        var idx = 0
        let element = list.first!
        list.swapAt(idx, count-1)
        _=list.popLast()
        while idx > count {
            let (left, right) = (idx*2+1,idx*2+2)
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
                    list.swapAt(idx, left)
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
    static func <(lhs:Node,rhs:Node) ->Bool {
        return lhs.cost < rhs.cost
    }
    static func ==(lhs:Node,rhs:Node) ->Bool {
        return lhs.vertex == rhs.vertex
    }
}

let input = readLine()!.split{$0==" "}.map{Int(String($0))!}
let (nCnt,eCnt,k,start) = (input[0],input[1],input[2],input[3]-1)
var graph = Array(repeating:[Node](),count:nCnt)
var res = [Int]()
var visited = Array(repeating:Int.max, count:nCnt)
_=(0..<eCnt).map { _ in
    let se = readLine()!.split{$0==" "}.map{Int(String($0))! - 1}
    let (s,e) = (se[0],se[1])
    graph[s].append(Node(vertex: e,cost: 1))
}
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
        _=graph[curNode.vertex].map{
            if visited[$0.vertex] > visited[curNode.vertex] + 1 {
                visited[$0.vertex] = visited[curNode.vertex] + 1
                priority.insert(Node(vertex: $0.vertex, cost: visited[$0.vertex]))
                if k == visited[$0.vertex] {
                    res.append($0.vertex+1)
                }
            }
        }
    }
}

dijkstra()


print(res.isEmpty ? "\(-1)" : res.reduce(""){"\($0)\($1)\n"})
