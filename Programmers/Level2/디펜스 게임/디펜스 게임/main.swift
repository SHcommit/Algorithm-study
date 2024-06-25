//
//  main.swift
//  디펜스 게임
//
//  Created by 양승현 on 6/25/24.
//

import Foundation

// MARK: - 1트

// 근데 n명의 병사는 최대 1,000,000,000이고, enemy의 길이는 최대 1,000,000이야. 그래서

// n^2로 탐색하면 시간초과남.

// 그래도 한번 해봄 처음에,, 내가생각한 최선은 bfs탐색인데, 그냥 사실 조건처리가 없어서 n^2였다고 보면됨.
//
//typealias Element = (n: Int, k: Int, round: Int)
//func solution(_ n:Int, _ k:Int, _ enemy:[Int]) -> Int {
//  var queue: [Element] = [(n,k,1)]
//  var maxRound = 0
//  var idx = 0
//  while idx < queue.count {
//    let c = queue[idx]
//    idx += 1
//    if c.k == 0 && c.n <= 0 {
//      maxRound = max(maxRound, c.round-1)
//      continue
//    }
//    
//    if c.round >= enemy.count { return enemy.count }
//    for i in (0..<2) {
//      let 무적권 = i == 0
//      if 무적권 {
//        if c.k > 0 {
//          queue.append((c.n, c.k-1, c.round+1))
//        }
//      } else {
//        if c.n >= enemy[c.round-1] {
//          queue.append((c.n - enemy[c.round], c.k, c.round+1))
//        }
//      }
//    }
//  }
//  return maxRound
//}
//
//print(solution(2, 4, [3, 3, 3, 3]))

// MARK: - 2트
// 아 이거다. 이거였어..
// 이문제 풀면서 어떻게 N^2가 아닌 시간 단축을 해볼까? 그리디하게 풀어나가는거야.

// 일단 처음에 n명의 병사들을 매 라운드마다 다써버려. 그리고 처치한 병사들은 우선순위 큐에 저장하는데, 더이상 처치할 병사가 없을떄 우선권을 쓴다. 이때 큐에 저장한 병사가 지금 까만권을 사용할 병사보다 높은 수라면, 까만 권을 그 이전에 처치한 병사한테 쓰고, 지금 병사를 큐에 추가한다… 와.. 대박

// 우선순위 큐를 썼는데 좋은점은.가장 높은 node를 우선으로 꺼낼 수 있다는 점이고, 그리디하게 문제를 구현할떄도 적용이 수월하다.
func solution(_ n:Int, _ k:Int, _ enemy:[Int]) -> Int {
  var k = k, n = n, ans = 0, pq = Heap<Int>(sort: >)
  
  for e in enemy {
    n -= e
    pq.insert(e)
    if n < 0 && k == 0 { break }
    if n < 0 {
      k -= 1
      n += pq.remove()!
    }
    ans += 1
  }
  return ans
}

public struct Heap<T> {
  var nodes = [T]()
  
  private var orderCriteria: (T, T) -> Bool
  
  public init(sort: @escaping (T, T) -> Bool) {
    self.orderCriteria = sort
  }
  
  public init(array: [T], sort: @escaping (T, T) -> Bool) {
    self.orderCriteria = sort
    configureHeap(from: array)
  }
  
  private mutating func configureHeap(from array: [T]) {
    nodes = array
    for i in stride(from: (nodes.count/2-1), through: 0, by: -1) {
      shiftDown(i)
    }
  }
  
  public var isEmpty: Bool {
    return nodes.isEmpty
  }
  
  public var count: Int {
    return nodes.count
  }
  
  @inline(__always) internal func parentIndex(ofIndex i: Int) -> Int {
    return (i - 1) / 2
  }
  
  @inline(__always) internal func leftChildIndex(ofIndex i: Int) -> Int {
    return 2*i + 1
  }
  
  @inline(__always) internal func rightChildIndex(ofIndex i: Int) -> Int {
    return 2*i + 2
  }
  
  public func peek() -> T? {
    return nodes.first
  }
  
  public mutating func insert(_ value: T) {
    nodes.append(value)
    shiftUp(nodes.count - 1)
  }
  
  public mutating func insert<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
    for value in sequence {
      insert(value)
    }
  }
  
  public mutating func replace(index i: Int, value: T) {
    guard i < nodes.count else { return }
    remove(at: i)
    insert(value)
  }
  
  @discardableResult public mutating func remove() -> T? {
    guard !nodes.isEmpty else { return nil }
    
    if nodes.count == 1 {
      return nodes.removeLast()
    } else {
      let value = nodes[0]
      nodes[0] = nodes.removeLast()
      shiftDown(0)
      return value
    }
  }
  
  @discardableResult public mutating func remove(at index: Int) -> T? {
    guard index < nodes.count else { return nil }
    
    let size = nodes.count - 1
    if index != size {
      nodes.swapAt(index, size)
      shiftDown(from: index, until: size)
      shiftUp(index)
    }
    return nodes.removeLast()
  }
  
  internal mutating func shiftUp(_ index: Int) {
    var childIndex = index
    let child = nodes[childIndex]
    var parentIndex = self.parentIndex(ofIndex: childIndex)
    
    while childIndex > 0 && orderCriteria(child, nodes[parentIndex]) {
      nodes[childIndex] = nodes[parentIndex]
      childIndex = parentIndex
      parentIndex = self.parentIndex(ofIndex: childIndex)
    }
    
    nodes[childIndex] = child
  }
  
  internal mutating func shiftDown(from index: Int, until endIndex: Int) {
    let leftChildIndex = self.leftChildIndex(ofIndex: index)
    let rightChildIndex = leftChildIndex + 1
    
    var first = index
    if leftChildIndex < endIndex && orderCriteria(nodes[leftChildIndex], nodes[first]) {
      first = leftChildIndex
    }
    if rightChildIndex < endIndex && orderCriteria(nodes[rightChildIndex], nodes[first]) {
      first = rightChildIndex
    }
    if first == index { return }
    
    nodes.swapAt(index, first)
    shiftDown(from: first, until: endIndex)
  }
  
  internal mutating func shiftDown(_ index: Int) {
    shiftDown(from: index, until: nodes.count)
  }
  
}
extension Heap where T: Equatable {
  public func index(of node: T) -> Int? {
    return nodes.index(where: { $0 == node })
  }
  
  @discardableResult public mutating func remove(node: T) -> T? {
    if let index = index(of: node) {
      return remove(at: index)
    }
    return nil
  }
}
