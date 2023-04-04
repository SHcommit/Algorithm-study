//
//  main.swift
//  [baekjoon]2550
//
//  Created by 양승현 on 2023/04/03.
//

import Foundation

let n = Int(readLine()!)!
let inputs = Array(zip(
  readLine()!.split{$0==" "}.map{Int(String($0))!},
  readLine()!.split{$0==" "}.map{Int(String($0))!}))
var lists = Array(repeating: 0, count: n)
_=(0..<n).map{ i in
  lists[inputs.firstIndex{ $0.1 == inputs[i].0 }!] = i
}
var dp = Array(repeating: 1, count: n)
var cache = [lists.first!]

func bs(_ target: Int, seq: inout [Int]) -> Int {
  var l = 0, r = seq.count - 1, m = 0
  while l<r {
    m = (l+r)/2
    if target>seq[m] { l = m + 1
    }else { r = m }
  }
  seq[r] = target
  return r
}

func lis() {
  _=(1..<n).map{
    if lists[$0] > cache.last! {
      cache.append(lists[$0])
      dp[$0] = cache.count
    }else {
      let idx = bs(lists[$0], seq: &cache) + 1
      dp[$0] = idx
    }
  }
}

func backTracking() -> [Int] {
  var length = dp.max()!
  var res: [Int] = []
  for i in stride(from: lists.count-1, through: 0, by: -1) where dp[i] == length {
    res.append(inputs[lists[i]].0)
    length -= 1
  }
  return res.sorted()
}
lis()
print("\(cache.count)\n\(backTracking().map{String($0)}.joined(separator: " "))")
