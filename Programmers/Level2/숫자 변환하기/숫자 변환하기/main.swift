//
//  main.swift
//  숫자 변환하기
//
//  Created by 양승현 on 6/17/24.
//

import Foundation

typealias Element = (target: Int ,cnt: Int)

@inline(__always)
func isOutOfY(target: Int, y: Int) -> Bool {
  return target > y
}

@inline(__always)
func makeNextTargets(_ current: Int, from operators: [Int]) -> [Int] {
  return [current*operators[0], current*operators[1], current+operators[2]]
}

func encode(target: Int, y: Int, by operators: [Int]) -> Int {
  var queue: [Element] = [(target, 0)]
  var visited = Array(repeating: false, count: y+1)
  visited[target] = true
  var queueIdx = 0
  while queue.count > queueIdx {
    let current = queue[queueIdx]
    if current.target == y { return current.cnt }
    let nextTargets = makeNextTargets(current.target, from: operators)
    for nextTarget in nextTargets {
      if isOutOfY(target: nextTarget, y: y) { continue }
      if visited[nextTarget] { continue }
      visited[nextTarget] = true
      queue.append((nextTarget, current.cnt+1))
    }
    queueIdx += 1
  }
  return -1
}

func solution(_ x:Int, _ y:Int, _ n:Int) -> Int {
  return encode(target: x, y: y, by: [2,3,n])
}
