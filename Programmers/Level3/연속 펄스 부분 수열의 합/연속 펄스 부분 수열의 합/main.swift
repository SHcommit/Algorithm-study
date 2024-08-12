//
//  main.swift
//  연속 펄스 부분 수열의 합
//
//  Created by 양승현 on 8/12/24.
//

import Foundation

/// dp 부분 합 최대 구해감
func solution(_ sequence:[Int]) -> Int64 {
  let length = sequence.count
  let plusBased = sequence.enumerated().map { $0%2 == 1 ? $1*(-1) : $1 }
  var plusBasedBuf = [plusBased[0]]
  let minusBased = sequence.enumerated().map { $0%2 == 1 ? $1 : $1*(-1) }
  var minusBasedBuf = [minusBased[0]]
  
  for i in 1..<length {
    let res1 = max(plusBasedBuf[i-1] + plusBased[i], plusBased[i])
    plusBasedBuf.append(res1)
    let res2 = max(minusBasedBuf[i-1]+minusBased[i], minusBased[i])
    minusBasedBuf.append(res2)
  }
  let r1 = plusBasedBuf.max()!
  let r2 = minusBasedBuf.max()!
  return Int64(r1 > r2 ? r1 : r2)
}
