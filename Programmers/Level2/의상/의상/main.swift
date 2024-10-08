//
//  main.swift
//  의상
//
//  Created by 양승현 on 10/8/24.
//

import Foundation

/// A종류 N개, B종류 M개가 있을떄 최소 한가지 옷 입고 모든 옷 입는 경우는 (N+1)(M+1) -1
/// 이게 확장되서 x종류 X개, y종류 Y개, z종류 Z개, m종류 M개 있을떄 최소 한가지 에서 모든 옷 입는 경우는 (X+1)(Y+1)(Z+1)(M+1)-1
func solution(_ clothes: [[String]]) -> Int {
  clothes
    .reduce(into: [String: Int]()) { p, n in p[n[1], default: 1] += 1 }
    .values
    .reduce(1) { p, n in p * n } - 1
}



/// 테스트 1번만 시간초과남
func combi(n: Int, r: Int) -> [[Int]] {
  var cache: [[Int]] = []
  func _combi(_ start: Int, seq: [Int]) {
    if seq.count == r {
      cache.append(seq)
      return
    }
    if start > n { return }
    for i in start...n {
      _combi(i+1, seq: seq + [i])
    }
  }
  _combi(1, seq: [])
  return Array(cache)
}
func solution1(_ clothes:[[String]]) -> Int {
  let dict = clothes.reduce(into: [String: [String]]()) { p, n in
    p[n[1], default: []].append(n[0])
  }
  let indexedDict = dict.keys.enumerated().reduce(into: [Int: Int]()) { p, n in
    let idx = n.0 + 1
    let key = n.1
    p[idx] = dict[key, default: []].count
  }
  var ans = 0
  let n = dict.keys.count
  for i in 1...n {
    var seq = combi(n: n, r: i)
    ans += seq.reduce(0) { p, s in
      p + s.reduce(1) { p, n in p*indexedDict[n, default: 1] }
    }
  }
  
  return ans
}
