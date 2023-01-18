//
//  main.swift
//  [baekjoon]14284
//
//  Created by 양승현 on 2023/01/18.
//

import Foundation

struct Heap<T> where T: Comparable {
    private var list:[T] = []
    let isLeftSmall: (T,T) -> Bool
    init(isLeftSmall: @escaping (T, T) -> Bool) {
        self.isLeftSmall = isLeftSmall
    }
    init() {
        self.init(isLeftSmall: <)
    }
    var isEmpty: Bool {
        return list.isEmpty
    }
    var count: Int {
        return list.count
    }
}
extension Heap {
    mutating func insert(_ element: T) {
        var idx = count
        list.append(element)
        while idx > 0 && isLeftSmall(list[idx],list[(idx-1)/2]) {
            list.swapAt(idx, (idx-1)/2)
            idx = (idx - 1)/2
        }
    }
    mutating func delete() ->T? {
        guard !isEmpty else {
            return nil
        }
        guard 1 != count else {
            return list.removeFirst()
        }
        var idx = 0
        let element = list.first!
        list.swapAt(idx,count-1)
        _=list.removeLast()
        while idx < count {
            let (left,right) = (idx*2+1,idx*2+2)
            if right < count {
                if isLeftSmall(list[left],list[right]) && isLeftSmall(list[left],list[idx]) {
                    list.swapAt(left, idx)
                    idx = left
                }else if isLeftSmall(list[right], list[idx]) {
                    list.swapAt(right, idx)
                    idx = right
                } else {
                    break
                }
            } else if left < count {
                if isLeftSmall(list[left],list[idx]) {
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
struct Node: Comparable {
    let vertex: Int
    let cost: Int
    static func <(lhs:Node,rhs:Node) ->Bool {
        return lhs.cost<rhs.cost
    }
}
let temp = readLine()!.split{$0==" "}.map{Int(String($0))!}
let (vCnt,eCnt) = (temp[0],temp[1])
var graph = Array(repeating:[Node](),count:vCnt)
_=(0..<eCnt).map{ _ in
    let input = readLine()!.split{$0==" "}.map{Int(String($0))!}
    let (s,e,c) = (input[0]-1,input[1]-1,input[2])
    graph[s].append(Node(vertex: e, cost: c))
    graph[e].append(Node(vertex: s, cost: c))
}
let input = readLine()!.split{$0==" "}.map{Int(String($0))!}
let (first,second) = (input[0]-1,input[1]-1)
var dir = Array(repeating:Int.max,count:vCnt)
func dijkstra(_ start:Int) {
    var priority = Heap<Node>()
    priority.insert(Node(vertex: start, cost: 0))
    dir[start] = 0
    while !priority.isEmpty {
        guard let pop = priority.delete() else {
            break
        }
        if pop.cost > dir[pop.vertex] { continue }
        _=graph[pop.vertex].map{
            if dir[$0.vertex] > dir[pop.vertex] + $0.cost {
                dir[$0.vertex] = dir[pop.vertex] + $0.cost
                priority.insert(Node(vertex: $0.vertex, cost: dir[$0.vertex]))
            }
        }
    }
}
dijkstra(first)
print(dir[second])
