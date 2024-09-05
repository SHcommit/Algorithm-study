//
//  main.swift
//  [baekjoon]2295
//
//  Created by 양승현 on 9/4/24.
//

import Foundation

/// 일반 collection.contins() 는 시간복잡도가 O(n)임
/// 그러나 이분탐색은 O(logn)임 이때 탐색할 배열은 정렬되야함. 무저건무저건이야~~
let u = (0..<Int(readLine()!)!).map { _ in Int(readLine()!)! }.sorted(by: <)
var sum = [Int]()
for i in 0..<u.count {
  for j in i..<u.count {
    sum.append(u[i]+u[j])
  }
}
sum.sort(by: <)
func execute() {
  for i in stride(from: u.count-1, through: 0, by: -1) {
    for j in 0..<i {
      if bs(u[i]-u[j], seq: sum) {
        print(u[i])
        return
      }
    }
  }
}

func bs(_ target: Int, seq: [Int]) -> Bool {
  var l = 0, r = seq.count-1, m = 0
  while l<=r {
    m = (l+r)/2
    if seq[m] < target {
      l = m+1
    } else if seq[m] > target {
      r = m-1
    } else {
      return true
    }
  }
  return false
}

execute()
