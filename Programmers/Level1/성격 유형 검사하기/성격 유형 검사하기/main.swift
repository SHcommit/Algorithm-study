//
//  main.swift
//  성격 유형 검사하기
//
//  Created by 양승현 on 7/5/24.
//

import Foundation

/// 주의할점:
/// 4보다 클 경우는 choice - 4를 해주는게 맞는데,
/// 4보다 작을 경우엔 1번은 3점 이렇게 오름차순으로 시작되기에 4-choice를 해주어야함
func solution(_ survey:[String], _ choices:[Int]) -> String {
  let personality = "RTCFJMAN".map { String($0) }
  var scores = personality.reduce(into: [String: Int]()) { $0[$1] = 0 }
  for (i, input) in survey.enumerated() {
    let s = input.map { String($0) }
    let choice = choices[i]
    if 1...3 ~= choice { scores[s[0]]! += 4 - choice }
    else if 5...7 ~= choice { scores[s[1]]! += choice - 4 }
  }
  return stride(from: 0, to: personality.count, by: 2).reduce("") {
    let a = personality[$1]
    let b = personality[$1+1]
    if scores[a]! == scores[b]! { return $0 + (a < b ? a : b) }
    return $0 + (scores[a]! > scores[b]! ? a : b)
  }
}
