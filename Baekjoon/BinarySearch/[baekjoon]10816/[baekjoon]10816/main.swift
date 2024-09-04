//
//  main.swift
//  [baekjoon]10816
//
//  Created by 양승현 on 9/4/24.
//

import Foundation

_=readLine()
let seq = readLine()!.split{$0==" "}.compactMap{Int(String($0))}.sorted(by: <)
_=readLine()
let targets = readLine()!.split{$0==" "}.compactMap{Int(String($0))}

func lowerIdx(target: Int) -> Int {
  var l = 0, r = seq.count
  while l<r {
    let m = (l+r)/2
    /// 커?! 그러면 r 이 왼쪽으로 간다. 그러면서 lower idx를 찾아나간다.
    if seq[m] >= target {
      r = m
    } else {
      l = m+1
    }
  }
  return l
}

func upperIdx(target: Int) -> Int {
  var l = 0, r = seq.count
  while l<r {
    let m = (l+r)/2
    /// 이거는 타겟이 가까우면 이제 left가 오른쪽으로 이동한다. 그렇게 target의 min upper idx를 찾는다.
    if seq[m] > target {
      r = m
    } else {
      l = m + 1
    }
  }
  return l
}

print(targets.map { "\(upperIdx(target: $0) - lowerIdx(target: $0))" }.joined(separator: " "))
