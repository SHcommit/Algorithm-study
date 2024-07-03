//
//  main.swift
//  11659
//
//  Created by 양승현 on 7/3/24.
//

import Foundation

@inline(__always)
func readIntSeq() -> [Int] { readLine()!.split{$0==" "}.map { Int($0)! } }
let recur = readIntSeq().last!
let seq = readIntSeq()
var prefixSums = [0] + seq
for i in 1...seq.count { prefixSums[i] += prefixSums[i-1] }
for _ in 0..<recur {
  let se = readIntSeq()
  print(prefixSums[se[1]] - prefixSums[se[0]-1])
}
