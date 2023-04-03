//
//  main.swift
//  [baekjoon]11568
//
//  Created by 양승현 on 2023/04/04.
//

import Foundation

func bs(_ target: Int, seq: inout [Int]){
  var l=0, r=seq.count-1, m=0
  while l<r {
    m = (l+r)/2
    if target>seq[m] { l = m+1 }
    else { r = m }
  }
  seq[r] = target
}
let n = Int(readLine()!)!
let lists = readLine()!.split{$0==" "}.map{Int(String($0))!}
var dp = [lists[0]]
_=(1..<n).map{
  if lists[$0]>dp.last! { dp.append(lists[$0]) }
  else { bs(lists[$0], seq: &dp) }
}
print(dp.count)
