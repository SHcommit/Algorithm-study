//
//  main.swift
//  등산코스 정하기
//
//  Created by 양승현 on 8/19/24.
//

import Foundation


/// 다익스트라를 통해서도 풀수 있고 bfs도 풀어보려고한다.
///
/// 다익스트라로 풀 때 최단 경로를 파악할 수단 인 min(distance[nextNode], distance[curNode] + curValue) 이걸 적용해서 최소비용들을 탐구해 나가는게
/// 기본 개념인데 이 문제에선 변형을 해야한다.
///
/// intensity는 등산 경로 중 가장 큰 이동 시간을 의미하는데, 이게 가장 적은걸 찾아야한다.
///
/// 다익스트라를 구현할 때는 출발지점에서 도착지점(봉우리)까지 등산경로가 최소한의 이동 경로가 되도록 구현해나가야 한다.
/// 이때 문제는 언제까지 다익스트라 탐색을 할것인지인데, 시작지점이 여러개인 경우에, 특정 노드로갈 비용이 최소한의 비용으로 구해진다면, 상대적으로 큰 비용을 들여서 가지 않아도
/// 다른 시작 지점에서 해당 경로를 거쳐서 봉우리까지 갈 수 있는의미여서 제외하는 등의 조건을 추가해야한다.
///
/// 그리고 23,24,25문제에서 초과가 발생될 수 있는데, 생각해보면 queue에서 빼면서 탐색할 때 contains를 사용하면 최악의 경우 O(n^2)느낌으로.. 물론 봉우리는 5만개지만..
/// 그래서 딕셔너리를  통해서 해결해줌
public struct Heap<T> {
  private var nodes = [T]()
  private var comparer: (T,T) -> Bool
  public init(comparer: @escaping (T,T)->Bool) { self.comparer = comparer }
  var isEmpty: Bool { nodes.isEmpty }
  @inline(__always) internal func parentIndex(ofIndex i: Int) -> Int { (i-1)/2 }
  @inline(__always) internal func leftChildIndex(ofIndex i: Int) -> Int { i*2+1 }
  @inline(__always) internal func rightChildIndex(ofIndex i: Int) -> Int { i*2+2 }
  public func peek() -> T? { nodes.first }
  internal mutating func shiftUp(_ index: Int) {
    var childIdx = index
    let child = nodes[childIdx]
    var parentIdx = parentIndex(ofIndex: childIdx)
    
    while childIdx > 0 && comparer(child, nodes[parentIdx]) {
      nodes[childIdx] = nodes[parentIdx]
      childIdx = parentIdx
      parentIdx = parentIndex(ofIndex: childIdx)
    }
    nodes[childIdx] = child
  }
  internal mutating func shiftDown(from index: Int, until endIndex: Int) {
    let leftChildIdx = self.leftChildIndex(ofIndex: index)
    let rightChildIdx = leftChildIdx + 1
    
    var first = index
    if leftChildIdx < endIndex && comparer(nodes[leftChildIdx], nodes[first]) {
      first = leftChildIdx
    }
    if rightChildIdx < endIndex && comparer(nodes[rightChildIdx], nodes[first]) {
      first = rightChildIdx
    }
    if first == index { return }
    nodes.swapAt(index, first)
    shiftDown(from: first, until: endIndex)
  }
  
  internal mutating func shiftDown(_ index: Int) {
    shiftDown(from: index, until: nodes.count)
  }
  
  public mutating func insert(_ value: T) {
    nodes.append(value)
    shiftUp(nodes.count-1)
  }
  
  @discardableResult public mutating func remove() -> T? {
    if nodes.isEmpty { return nil }
    if nodes.count == 1 { return nodes.removeLast() }
    let value = nodes[0]
    nodes[0] = nodes.removeLast()
    shiftDown(0)
    return value
  }
}


typealias E = (node: Int, weight: Int)
typealias intensity = Int

var graph: [Int: [E]] = [:]
var n: Int = 0
var summits: [Int] = []
var summitDict: [Int: Bool] = [:]
var intensities: [Int] = []
var queue: Heap<E> = .init(comparer: {$0.weight<$1.weight})

/// gates: 출입구
/// summits: 산봉우리
func solution(_ _n:Int, _ paths:[[Int]], _ gates:[Int], _ _summits:[Int]) -> [Int] {
  n = _n; summits = _summits; intensities = Array(repeating: Int.max, count: n+1)
  summitDict = _summits.reduce(into: [Int: Bool]()) { $0[$1] = true }
  graph = paths.reduce(into: [Int: [E]]()) { p, e in
    let i = e[0], j = e[1], w = e[2]
    p[i, default: []].append((j,w))
    p[j, default: []].append((i,w))
  }
  gates.forEach { 
    intensities[$0] = 0
    queue.insert(($0,0))
  }
  while let popped = queue.remove() {
    /// 최소를 찾는거니까! 이미 작은 경로 찾으면 의미 없지: ]
    if intensities[popped.node] < popped.weight || summitDict[popped.node, default: false] { continue }
    guard let nodes = graph[popped.node] else { continue }
    for next in nodes {
      let mm = max(popped.weight, next.weight)
      guard intensities[next.node] > mm else { continue }
      intensities[next.node] = mm
      queue.insert((next.node, mm))
    }
  }
  
  let parsed = summits.map { [$0, intensities[$0]] }
  return parsed
    .sorted { $0[1] == $1[1] ? $0[0] < $1[0] : $0[1] < $1[1] }
    .first!
}


print(solution(6, [[1, 2, 3], [2, 3, 5], [2, 4, 2], [2, 5, 4], [3, 4, 4], [4, 5, 3], [4, 6, 1], [5, 6, 1]], [1, 3], [5]))
