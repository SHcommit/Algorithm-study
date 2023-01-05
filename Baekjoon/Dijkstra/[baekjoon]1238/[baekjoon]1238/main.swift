//
//  main.swift
//  [baekjoon]1238
//
//  Created by 양승현 on 2023/01/05.
//

import Foundation

//MARK: - Data
struct Heap<T> where T: Comparable {
    var heap = [T]()
    let comparer: (T,T) -> Bool
    init(comparer: @escaping (T,T) -> Bool) {
        self.comparer = comparer
    }
    init() {
        self.init(comparer: <)
    }
}

//Operators
//작은애가 오른쪽에 와서 왼쪽에 있는 comparer가 커야 false됨
/*
 30
10      20
 이경우 가장 작은애랑바꾸야해 근데 그래서 left가 작을 경우! left 가 index보다 작은지!! 작으면 교환
 else if
  30
 20 10
    if1     5
        3       6
 이경우 5는 6의 아래로 갈 수 없음. 작은애가 올라가야한다.
 이경우 바꿀수있어? 있으면 바꿔야지!
            
    if2     5
        6       3
 아 그럼 이경우구나? 이경우엔 왼쪽이 못바꾸니까 오른쪽이 바꿀수있어?
 
 else       3
        6       5
    아 둘다 안되? 그럼 heapify 만족! 끝
 
 
 else if        3
            5
    왼쪽만있겠네? 그럼 왼쪽과 비교하면되겠다
 else
    더 위와 같은 경우네 그럼 더이상 heapify 수정할거없다!
 */
extension Heap {
    var isEmpty: Bool {
        return heap.isEmpty
    }
    mutating func insert(_ element: T) {
        var idx = heap.count
        heap.append(element)
        while idx > 0 && comparer(heap[idx], heap[(idx-1)/2]) {
            heap.swapAt(idx, (idx-1)/2)
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
        let res = heap.first
        heap.swapAt(0, heap.count-1)
        _ = heap.popLast()
        var idx = 0
        while idx < heap.count {
            let (left,right) = (idx*2+1, idx*2+2)
            if right < heap.count {
                if comparer(heap[right], heap[left]) && comparer(heap[idx], heap[left]) {
                    heap.swapAt(left, idx)
                    idx = left
                }else if comparer(heap[idx],heap[right]) {
                    heap.swapAt(right, idx)
                    idx = right
                }else {
                    break
                }
            } else if left < heap.count {
                if comparer(heap[idx],heap[left]) {
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
let (n,m,x) = (input[0],input[1],input[2])
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
    print(res.sorted(by: <).last!)
}

solution()
