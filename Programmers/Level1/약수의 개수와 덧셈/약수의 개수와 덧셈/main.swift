//
//  main.swift
//  약수의 개수와 덧셈
//
//  Created by 양승현 on 7/14/24.
//

import Foundation

/// 악수 구하는건 외워졌는데
func 약수(_ n: Int) -> Int {
  var buf = Set<Int>()
  for i in 1...Int(sqrt(Double(n))) {
    if n % i == 0 {
      buf.insert(i)
      buf.insert(n/i)
    }
  }
  return buf.count
}

func solution(_ left:Int, _ right:Int) -> Int {
  (left...right).reduce(0) { p, n in p + (약수(n)%2 == 0 ? n : -n) }
}


// MARK: - 타인 풀이
/// floor(sqrt(Double(number))) == sqrt(Double(number))
/// 이 조건을 통해서제곱근이 정수일 때 ! 약수의 개수가 홀수다.
/// 위 조건은 완전 제곱수 x^2를 찾는거. 9면 1 3 9 이렇게. 신기하네
///   sqrt는 Double반환. floor는 소수점 버림. 그래서 sqrt + 소수점버린거 is Equal sqrt한게 0으로 되면 완전 제곱수이고. 약수 개수가 홀수개.
