//
//  main.swift
//  숫자 짝궁
//
//  Created by 양승현 on 7/3/24.
//

import Foundation

// MARK: 1st 트라이
/// 포인터로 O(2n) = O(n)느끼믕로했는데.. 몇 부분에서 시간초과
func solution1(_ X:String, _ Y:String) -> String {
  let x = X.map { Int(String($0))! }.sorted(), y = Y.map { Int(String($0))! }.sorted()
  var l = 0, r = 0
  var seq: [Int] = []
  while l < x.count && r < y.count {
    if x[l] < y[r] { l += 1 }
    else if x[l] == y[r] {
      seq.append(x[l])
      l+=1
      r+=1
    }
    else { r += 1 }
  }
  if !seq.isEmpty, seq.filter ({ $0 > 0 }).count == 0 { return "0" }
  return seq.isEmpty ? "-1" : seq.sorted(by: >).map { String($0) }.joined()
}

// MARK: 2nd try 개수들을 기준으로 풀어나감.. 댑ㅏㄱ.
func reducer(str: String) -> [Character: Int] {
  return str.reduce(into: [Character: Int]()) { $0[$1, default: 0] += 1 }
}
func solution(_ X:String, _ Y:String) -> String {
  var xC = reducer(str: X), yC = reducer(str: Y)
  var seq : [Int] = []
  "0123456789".reversed().forEach { i in
    let minC = min(xC[i] ?? 0, yC[i] ?? 0)
    seq.append(contentsOf: (0..<minC).map { _ in Int("\(i)")! })
  }
  if !seq.isEmpty, seq.filter ({ $0 > 0 }).count == 0 { return "0" }
  return seq.isEmpty ? "-1" : seq.sorted(by: >).map { String($0) }.joined()
}

print(solution("100", "2345"))
