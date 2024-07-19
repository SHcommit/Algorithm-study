//
//  main.swift
//  괄호 회전하기
//
//  Created by 양승현 on 7/19/24.
//

import Foundation

/// 뭐지? 어제 분명했을때... 로직이 동일했던거같은데
/// 잠을 잘 못잔 상태에서 풀어서 그런가...
///
func solution(_ s:String) -> Int {
  let l = "[({".map { $0 }
  let ss = (s+s).map { $0 }
  return (0..<ss.count-s.count).filter { i in
    var stack: [Character] = []
    for j in i..<i+s.count {
      let t = ss[j]
      
      if l.contains(t) {
        stack.append(t)
      } else {
        if let popped = stack.popLast() {
          if !(popped == "(" && t == ")" ||
               popped == "{" && t == "}" ||
               popped == "[" && t == "]") {
            return false
          }
        } else {
          return false
        }
      }
    }
    return stack.isEmpty
  }.count
}

print(solution("}]()[{"))

/// 다른 사람의 풀이
/// 오.. replacingOccurences를 통해 {},(), []는 ""로 변경했다..
