//
//  main.swift
//  [baekjoon]11066
//
//  Created by 양승현 on 2023/01/03.
//

import Foundation

let n = Int(readLine()!)!
var res = ""
for _ in 0..<n {
    let n = Int(readLine()!)!
    var pages = Array(repeating: 0, count: n)
    pages = readLine()!.split{$0==" "}.map{Int(String($0))!}
    var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: n+1)
    var sum = Array(repeating: 0, count: n+1)
    for i in 1...n { sum[i] = sum[i-1] + pages[i-1] }
    for i in 1...n {
        for j in 1..<(n-i+1)   {
            dp[j][i+j] = 9999999999
            for k in j ..< (i + j) {
                dp[j][i + j] = min(dp[j][i + j], dp[j][k] + dp[k + 1][i + j] + sum[i + j] - sum[j - 1]);
            }
        }
    }
    res += "\(dp[1][n])\n"
}
print(res)
