//
//  main.swift
//  ps_가장큰수
//
//  Created by 양승현 on 10/29/24.
//

import Foundation

func solution(_ numbers:[Int]) -> String {
  { $0.first == "0" ? "0" : $0}(
    numbers
      .map { String($0) }
      .sorted { $0 + $1 > $1 + $0 }
      .joined())
}
print(solution([3, 30, 34, 5, 9]))
