//
//  main.swift
//  n^2배열 자르기
//
//  Created by 양승현 on 7/11/24.
//

import Foundation

// MARK: 1st try 시간초과
// 알고보니 n이 10^7 승임..
// 승현아!!!! 문제를 다 읽자! 이 습관을 고쳐야해!! 제한사항도 꼼꼼히 보아야한다!!!
func solution1(_ n:Int, _ left:Int64, _ right:Int64) -> [Int] {
  var buf = (0..<n).map {_ in (0..<n).map{_ in 0}}
  for i in 0..<n {
    for j in 0...i {
      buf[i][j] = i+1
      buf[j][i] = i+1
    }
  }
  return buf
    .flatMap{ $0 }
    .enumerated()
    .filter { $0.0 >= left && $0.0 <= right }
    .map { $0.1 }
}

// MARK: 2nd try. 뀨
func solution(_ n:Int, _ left:Int64, _ right:Int64) -> [Int] {
  return (left...right).map {
    let n = Int64(n), one = Int64(1), x: Int64 = $0 % n, y = $0 / n
    return Int(x > y ? x + one : y + one)
  }
}

print(solution(3, 2, 5))
