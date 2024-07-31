//
//  main.swift
//  큰 수 만들기
//
//  Created by 양승현 on 8/1/24.
//

import Foundation

/// 그리디 어렵다... 그리디한 마음이 없어서 그럴까..
/// ㅡ,ㅡ,ㅡ,ㅡ,ㅡ
///
/// 그리디하게 일단 앞쪽에서 큰거만 스택에 채움.
/// 다채웠는데, 아직 덜뺐다? 뒤에 원소부터 뺌. k 감소시킴
func solution(_ number:String, _ k:Int) -> String {
  var k = k
  var stack: [Character] = []
  for digit in number {
    while k > 0, !stack.isEmpty, stack.last! < digit {
      stack.removeLast()
      k -= 1
    }
    stack.append(digit)
  }
  
  while k > 0 {
    stack.removeLast()
    k -= 1
  }
  return String(stack)
}

print(solution("4177252841", 3))
