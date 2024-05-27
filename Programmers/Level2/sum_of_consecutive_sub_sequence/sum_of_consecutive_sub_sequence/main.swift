//
//  main.swift
//  sum_of_consecutive_sub_sequence
//
//  Created by 양승현 on 5/27/24.
//

import Foundation

func solution(_ seq:[Int], _ k:Int) -> [Int] {
  var s = 0, e = 0, sum = seq[s], ansS = 0, ansE = Int.max
  /// 또 정말 신기한건 seq.count를 while문 안에 매번 하는거 보다 이렇게 지역변수로 해야만 통과되네 ㅋㅋ;;
  let count = seq.count
  while s <= e {
    /// 아 이걸 매번 해줘서 그런가보다.. 여기서 도 O(n)이네.. 최악의 경우 O(n*m)이네 이런거 조심해야겠다.
    /// 루프 안에 루프 요고는 좀 그렇지
    /// sum = seq[s...e].reduce(0,+)
    if sum > k {
      sum -= seq[s]
      s += 1
    } else {
      if sum == k && abs(ansS - ansE) > abs(s-e) {
        ansS = s
        ansE = e
      }
      e += 1
      if e == count { break }
      sum += seq[e]
    }
  }
  return [ansS, ansE]
}

print(solution([2, 2, 2, 2, 2], 6))
