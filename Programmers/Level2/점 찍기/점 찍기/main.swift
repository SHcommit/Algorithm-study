//
//  main.swift
//  점 찍기
//
//  Created by 양승현 on 6/28/24.
//

import Foundation
/// x좌표를 탐색할때 x 탐색하면서 x^2 + y^2 = z^2 를 이용해서 최대 y값을 구할수 있음.
/// 근데 이때 0..<d Range에 대해 k 씩 곱해야함.
/// O(n)
func solution(_ k:Int, _ d:Int) -> Int64 {
  return stride(from:0, through: d, by: k)
    .map { x in
      let maxY = sqrt(Double(d*d) - Double(x*x))
      return Int64(maxY/Double(k) + 1) }
    .reduce(Int64(0),+)
}
print(solution(1, 5))
