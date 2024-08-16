//
//  main.swift
//  소수 찾기
//
//  Created by 양승현 on 8/16/24.
//

import Foundation


/// 문제 접근:
/// 1. 조합으로 numbers를 통해 만들 수 구함
/// 2. isPrime을 통해 소수인지 구함. 이때 소수는 1부터 제곱근 +1 전 수 만큼 반복하며 0으로나눠진다면 약수가 존재하는 것임을통해 소수판별
func solution(_ numbers:String) -> Int {
  let numbers = numbers.map { String($0) }
  let availableNumbers = (1...numbers.count)
    .map { i in
      combi(n: numbers.count, r: i)
        .compactMap { seq in Int(seq.map { numbers[$0] }.joined()) }
    }.flatMap { $0 }
  return Array(Set(availableNumbers))
    .filter(isPrime(number:))
    .count
}

func combi(n: Int, r: Int) -> [[Int]] {
  var buf: [[Int]] = []
  var visited = (0..<n).map { _ in false }
  func _combi(i: Int, seq: [Int]) {
    if seq.count == r {
      buf.append(seq)
      return
    }
    
    for j in 0..<n {
      if visited[j] { continue }
      visited[j] = true
      _combi(i: j, seq: seq + [j])
      visited[j] = false
    }
  }
  _combi(i: 0, seq: [])
  return buf
}

func isPrime(number: Int) -> Bool {
  if number < 2 { return false }
  
  for i in 2..<Int(sqrt(Double(number)))+1 {
    if number % i == 0 { return false }
  }
  return true
}

print(solution("011"))


