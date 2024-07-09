//
//  main.swift
//  k진수에서 소수 개수 구하기
//
//  Created by 양승현 on 7/9/24.
//

import Foundation

// MARK: - 1st try
/// 프라임 구하는건 원본 숫자를 제곱근한 숫자들로 나눌때 0인거는  구할수있음. (약수 구하는 느낌으로다가 1..자기자신 아니면 옵티머스 프라임인거.
///
/// 내 문제는 2번 테스트케이스에서 계속 틀림. 이유는 convert함수에서 특정 진수 구할 때 오류가 있었음.
/// 
/// - 10을 n진수로 구할때 Swift.String(_:radix:)를 사용하면됨.. 대박 메모!
///
/// - split(_:)함수는 특정한 구분자가 연이어 문자열에서 보일 경우 그들도 제거해줌. 예를들어 "1100011".split{$0=="0"}를 할 경우 ["11", "11"] 이렇게 말이지.

func isPrime(_ number: Int) -> Bool {
  var storage = Set<Int>()
  for i in 1...Int(sqrt(Double(number))) {
    if number % i == 0 {
      storage.insert(i)
      storage.insert(number/i)
    }
  }
  return storage.count == 2 ? true : false
}

func convert(_ n: Int, k: Int) -> String {
  if k == 10 { return "\(n)" }
  var kStr = ""
  var temp = n
  while temp != 0 {
    kStr += "\(temp % k)"
    temp/=k
  }
  return kStr
}

func solution1(_ n:Int, _ k:Int) -> Int {
  return convert(n, k:k)
    .reversed()
    .split{$0=="0"}
    .filter { isPrime(Int(String($0))!) }
    .count
}

// MARK: 2트. String(_:radix:)사용
func solution(_ n:Int, _ k:Int) -> Int {
  return String(n, radix: k)
    .split { $0=="0" }
    .filter { isPrime(Int(String($0))!) }
    .count
}

print(solution(437674, 3))
