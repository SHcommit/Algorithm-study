//
//  main.swift
//  [baekjoon]14938
//
//  Created by 양승현 on 2023/01/15.
//

import Foundation

struct Heap<T> where T: Comparable {
    private var list = [T]()
    private var isLeftSmall: (T,T) -> Bool
    init(isLeftSmall: @escaping (T,T)-> Bool) {
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
        while idx > 0 && isLeftSmall(list[idx], list[(idx-1/2)]) {
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
        _=list.removeLast()
        while idx > 0 {
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

struct Node: Comparable {
    var vertex: Int
    var cost: Int
    
    static func <(lhs:Node,rhs:Node) -> Bool {
        return lhs.cost < rhs.cost
    }
}

func dijkstra(_ start: Int, dir: inout [Int]) {
    var priority = Heap<Node>()
    priority.insert(Node(vertex: start, cost: 0))
    dir[start] = 0
    while !priority.isEmpty {
        guard let pop = priority.delete() else {
            break
        }
        if pop.cost > dir[pop.vertex] {
            continue
        }
        for node in graph[pop.vertex] {
            if dir[node.vertex] > dir[pop.vertex] + node.cost {
                dir[node.vertex] = dir[pop.vertex] + node.cost
                priority.insert(Node(vertex: node.vertex, cost: dir[node.vertex]))
            }
        }
    }
}
var nmr = readLine()!.split{$0==" "}.map{Int(String($0))!}
let (nCnt,mRange,eCnt) = (nmr[0],nmr[1],nmr[2])
var items = readLine()!.split{$0==" "}.map{Int(String($0))!}
var graph = Array(repeating: [Node](), count: nCnt)
var res = 0
_=(0..<eCnt).map { _ in
    let input = readLine()!.split{$0==" "}.map{Int(String($0))!}
    let (s,e,c) = (input[0]-1,input[1]-1,input[2])
    graph[s].append(Node(vertex: e, cost: c))
    graph[e].append(Node(vertex: s, cost: c))
}
for i in 0..<nCnt {
    var dir = Array(repeating: Int.max, count: nCnt)
    var temp = 0
    dijkstra(i, dir: &dir)
    _=dir.enumerated().filter{$0.element <= mRange}.map{temp += items[$0.offset]}
    res = max(res, temp)
}
print(res)
