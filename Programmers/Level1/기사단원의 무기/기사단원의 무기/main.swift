//
//  main.swift
//  기사단원의 무기
//
//  Created by 양승현 on 6/27/24.
//

import Foundation

func solution(_ n:Int, _ l:Int, _ p:Int) -> Int {
  return (1...n).map { divisor($0).count }.reduce(0) { $1>=l ? $0 + p : $0 + $1 }
}
func divisor(_ k: Int) -> [Int] {
  var set = Set<Int>()
  for i in 1...Int(sqrt(Double(k))) {
    if k%i == 0 {
      set.insert(i)
      set.insert(k / i)

    }
  }
  return Array(set)
}
//print(solution(5, 3, 2))


print(divisor(6))
