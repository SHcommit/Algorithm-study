//
//  main.swift
//  푸드 파이터 대회
//
//  Created by 양승현 on 6/28/24.
//

import Foundation

// 한 큐에 풀어보았다.

func solution(_ food:[Int]) -> String {
  { $0 + "0" + $0.reversed() }(
    food[1..<food.count]
    .map { $0 / 2 }
    .enumerated()
    .filter { $0.1 > 0 }
    .reduce(into: "") { p, n in p += (0..<n.1).map { _ in "\(n.0 + 1)" }.joined(separator: "") }
  )
}

print(solution([1, 4, 4, 6] ))
