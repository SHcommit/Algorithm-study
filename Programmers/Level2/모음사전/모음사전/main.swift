//
//  main.swift
//  모음사전
//
//  Created by 양승현 on 7/12/24.
//

import Foundation

// 첫 접근은 포문 5개 써봤다.
// 이 문제에선 5개 한정이었기에 사용했지만, 글자가 n개라면 포문을 동적으로 증, 감 을 못시킨다.
// 이럴때 재귀를 하자!!! dfs도 느낌이 비슷한데 재귀다! 재귀여!!!! 재귀인것이야!!!
//
// 재귀를 쓸때 주의할 점은 "언제 끝낼것인가" 이것이다. 프로그램에 맞기지 말고 조건을 작성 하자!!!!!
func solution(_ word:String) -> Int {
  let alphabet: [Int: String] = [0:"A", 1:"E", 2:"I", 3:"O", 4:"U"]
  var ans = 0, barrier = false
  func recur(_ str: String = "") {
    if str == word {
      barrier = true
      return
    }
    if str.count == 5 { return }
    for i in 0..<5 {
      if !barrier {
        ans += 1
        recur(str + alphabet[i]!)
      }
    }
  }
  recur()
  return ans
}

print(solution("AAAEE"))
