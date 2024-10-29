//
//  main.swift
//  process
//
//  Created by 양승현 on 10/29/24.
//

import Foundation

func solution(_ priorities:[Int], _ location:Int) -> Int {
  var indexedPriorities = priorities.enumerated().map { $0 }
  let maxList = priorities.sorted(by: >)
  var maxListIndex = 0
  var index = 0
  var executed: [(Int,Int)] = []
  while index < indexedPriorities.count {
    let maximum = maxList[maxListIndex]
    let process = indexedPriorities[index]
    if process.element < maximum {
      indexedPriorities.append(process)
    } else {
      executed.append(process)
      maxListIndex += 1
    }
    index += 1
  }
  return executed.firstIndex(where: { e in e.0 == location })! + 1
}

print(solution([1, 1, 9, 1, 1, 1], 0))
