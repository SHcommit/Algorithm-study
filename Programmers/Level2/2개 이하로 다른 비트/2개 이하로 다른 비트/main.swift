//
//  main.swift
//  2개 이하로 다른 비트
//
//  Created by 양승현 on 7/13/24.
//

import Foundation

// MARK: - 1st try.
//
// ㅁ..ㅁ 시간초과.

// 비트에서 0이아닌것은 nonzeroBitCount로 알 수 있다.
func solution1(_ numbers:[Int64]) -> [Int64] {
  numbers.map { n in
    for nn in n+1...Int64.max where (1...2)~=(n^nn).nonzeroBitCount { return nn }
    return 0
  }
}

/// 문제에서는 가장 작은걸 요구. 앞자리수가 0일때 그걸 1로바꾸고, 이전비트는 0으로 바꾸면 서로다른 수가 2개됨.
func solution(_ numbers:[Int64]) -> [Int64] {
  numbers.map { n in
    var n = n, nn: Int64 = 1
    while true {
      if n&nn == 0 {
        n|=nn
        return n^(nn>>1)
      }
      nn<<=1
    }
  }
}

print(solution([2,7]))
