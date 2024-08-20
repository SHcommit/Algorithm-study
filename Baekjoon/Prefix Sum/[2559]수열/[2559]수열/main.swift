//
//  main.swift
//  [2559]수열
//
//  Created by 양승현 on 8/20/24.
//

import Foundation
let nk = readLine()!.split{$0==" "}.compactMap { Int(String($0)) }
let seq = readLine()!.split{$0==" "}.compactMap { Int(String($0)) }
var prefixSum = [0] + seq
for i in 1...seq.count {
  prefixSum[i] += prefixSum[i-1]
}
print((nk[1]...seq.count).map {prefixSum[$0] - prefixSum[$0-nk[1]]}.max() ?? 0)
