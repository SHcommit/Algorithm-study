//
//  main.swift
//  [baekjoon]1309
//
//  Created by 양승현 on 2023/01/01.
//

import Foundation

let MODNUM = 9901
let n = Int(readLine()!)!
var dp = Array(repeating: 1, count: n+1)
dp[1] = 3
for i in 2..<n+1 {
    dp[i] = ( 2*dp[i-1] + dp[i-2] ) % MODNUM
}
print(dp[n])
