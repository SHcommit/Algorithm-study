//
//  main.swift
//  [baekjoon]1920_re
//
//  Created by 양승현 on 9/4/24.
//

import Foundation

/// n개의 정수 A(1...N) 이 주어질 때 안에 x정수가 존재하는지 알아내보라우
///
/// N이주어짐
/// N개의 정수 (A1...N)주어짐
/// M주어짐
/// M개의 수가 주어짐 이 수 안에 A1...N이 존재하는지 알아내면됨

_=readLine()
let a = readLine()!.split{$0==" "}.compactMap{Int(String($0))}.sorted(by: <)
_=readLine()
let targets = readLine()!.split{$0==" "}.compactMap{Int(String($0))}

func binarySearch(target: Int) -> Int {
  var l = 0, r = a.count-1, m = 0
  while l < r {
    m = (l+r)/2
    if target > a[m] {
      l = m + 1
    } else if target < a[m] {
      r = m-1
    } else {
      return 1
    }
  }
  return 0
}
targets.forEach {
  print(binarySearch(target: $0))
}
