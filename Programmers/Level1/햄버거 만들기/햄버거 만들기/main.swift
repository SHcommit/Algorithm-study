//
//  main.swift
//  햄버거 만들기
//
//  Created by 양승현 on 6/30/24.
//

import Foundation

/// 처음 접근 방법은 모든 1을 저장하고, 맨 끝 1부터 4개씩 묶어서 탐색하려고했는데, 테트리스 느낌으로다가 중간에 버거 만들면 위에 재료가 올라져나와야함.
///
/// 차곡 차곡 쌓이다가 원하는 조건일때 1,2,3,1이 쌓인 경우를 탐색하기 좋은 방법을 스택을 떠올렸고 그렇게 품
func solution(_ ingredients:[Int]) -> Int {
  var stack: [Int] = []
  return ingredients.map { ingredient in
    stack.append(ingredient)
    if ingredient == 1 && stack.count >= 4 {
      let lastIdx = stack.count-1
      if stack[lastIdx-3...lastIdx].map ({ String($0) }).joined() == "1231" {
        stack.removeLast(4)
        return true
      }
    }
    return false
  }
  .filter { $0 }
  .count
}
