//
//  main.swift
//  pairs_of_Int_between_two_circles
//
//  Created by 양승현 on 5/24/24.
//

import Foundation

/// 정수 쌍 구하는 공식: x^2 + y^2 = r^2
/// y^2 = r^2 - x^2
/// 작은원은 현재 위치보다 큰 값이 개수에 포함.
/// 큰 원은 현재 위치보다 작은 값의 정수가 개수에 포함.
/// +1하면 됨.

func solution(_ r1:Int, _ r2:Int) -> Int64 {
  return (1...r2).map { x in
    let minY = Int(exactly: ceil(sqrt(Double(r1*r1 - x*x)))) ?? 0
    let maxY = Int(exactly: floor(sqrt(Double(r2*r2 - x*x)))) ?? 0
    
    return Int64((maxY - minY) + 1)
  }.reduce(0, +) * 4
}

print(solution(2, 3))
