//
//  main.swift
//  [baekjoon]1238
//
//  Created by 양승현 on 2023/01/05.
//

import Foundation

//MARK: - Data
struct Heap<T> where T: Comparable {
    private var heap = [T]()
    let compare: (T,T) -> Bool
    init(compare: @escaping (T,T) -> Bool) {
        self.compare = compare
    }
    init() {
        self.init(compare: <)
    }
}

extension Heap {
    var isEmpty: Bool {
        return heap.isEmpty
    }
    mutating func insert(_ element: T) {
        var idx = heap.count
        heap.append(element)
        //아래에있는 내가 위의 부모보다 커야하는데!! 작다면? 위 아래 바꿔야함
        //작은애를 오른쪽에
        while idx > 0 && compare(heap[(idx-1)/2], heap[idx]) {
            heap.swapAt((idx-1)/2, idx)
            idx = (idx-1)/2
        }
    }
    mutating func delete() -> T? {
        guard !heap.isEmpty else {
            return nil
        }
        guard heap.count != 1 else {
            return heap.removeFirst()
        }
        let res = heap.first!
        heap.swapAt(0, heap.count-1)
        _ = heap.removeLast()
        var idx = 0
        while idx < heap.count {
            let (left,right) = (idx*2+1,idx*2+2)
            if right < heap.count {
                if compare(heap[left], heap[right]) && compare(heap[right], heap[idx]) {
                    //  30
                    //50 20
                    //오른쪽이 왼쪽보다 작은경우, 원래 자식이 부모보다 커야하는데 자식이 더 작은 경우,,
                    heap.swapAt(right, idx)
                    idx = right
                }else if compare(heap[left],heap[idx]) {
                    //   30
                    // 20 50
                    //이경우 원래는 자식이 부모보다 커야하는데 자식이 작아? 그럼 바꿔야지
                    heap.swapAt(left, idx)
                    idx = left
                }else {
                    break
                }
            }else if left < heap.count {
                if compare(heap[left], heap[idx]) {
                    heap.swapAt(left, idx)
                    idx = left
                }else {
                    break
                }
            }else {
                break
            }
        }
        return res
    }
    
    
}
struct Node {
    let vertex: Int
    let cost: Int
}
extension Node: Equatable, Comparable {
    static func <(lhs: Node, rhs: Node) -> Bool {
        return lhs.cost < rhs.cost
    }
}

//MARK: - Properties
var input = readLine()!.split{$0==" "}.map{Int(String($0))!}
let (n,m,x) = (input[0],input[1],input[2] - 1)
var graph = Array(repeating: [Node](), count: n)

var res = Array(repeating: 0, count: n)
var lastDist = res
(0..<m).forEach { _ in
    let temp = readLine()!.split{$0==" "}.map{Int(String($0))!}
    let (s,e,c) = (temp[0]-1,temp[1]-1,temp[2])
    graph[s].append(Node(vertex: e, cost: c))
}

func dijkstra(_ start: Int, _ last: Bool = false) {
    var dist = Array(repeating: Int.max, count: n)
    dist[start] = 0
    var priority = Heap<Node>()
    priority.insert(Node(vertex: start, cost: 0))
    while let curNode = priority.delete() {
        if dist[curNode.vertex] < curNode.cost { continue }
        for node in graph[curNode.vertex] {
            if dist[curNode.vertex] + node.cost < dist[node.vertex] {
                dist[node.vertex] = dist[curNode.vertex] + node.cost
                priority.insert(Node(vertex: node.vertex, cost: dist[node.vertex]))
            }
        }
    }
    guard last else {
        res[start] = dist[x]
        return
    }
    lastDist = dist
}

func solution() {
    (0..<n).forEach { dijkstra($0) }
    dijkstra(x,true)
    (0..<res.count).forEach { res[$0] += lastDist[$0] }
    print(res.max()!)
}

solution()
