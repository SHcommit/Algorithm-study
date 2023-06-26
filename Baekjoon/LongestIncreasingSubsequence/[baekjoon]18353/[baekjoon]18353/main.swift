//
//  main.swift
//  [baekjoon]18353
//
//  Created by 양승현 on 2023/06/26.
//

import Foundation
func bs(_ target: Int, seq: inout [Int]) {
  var l = 0, r = seq.count, mid = 0
  while l<r {
    mid = (l+r)/2
    if target > seq[mid] { l = mid + 1 }
    else { r = mid }
  }
  seq[r] = target
}

let n = Int(readLine()!)!
var seq = readLine()!.split{$0==" "}.map{ Int(String($0))!}
seq.reverse()
func lis() {
  var list = [seq[0]]
  _=(1..<n).map {
    if seq[$0] > list.last! { list.append(seq[$0]) }
    else { bs(seq[$0], seq: &list)}
  }
  print(n-list.count)
}
lis()
