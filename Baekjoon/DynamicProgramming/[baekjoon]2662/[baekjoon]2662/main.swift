//
//  main.swift
//  [baekjoon]2662
//
//  Created by 양승현 on 2023/03/06.
//

import Foundation
var res = ""
var nm = readLine()!.split{$0==" "}.map{Int(String($0))!}
let (n,m) = (nm[0],nm[1])
var lists: [[Int]] = (0..<n).map{ _ in
    return readLine()!.split{$0==" "}.map{Int(String($0))!}
}
lists.insert(Array(repeating: 0, count: m+1), at: 0)
var dp = Array(repeating: Array(repeating: 0, count: n+1), count: m+1)
var cache = dp
for i in 1...m { // 기업 초이스
    for j in 1...n { // max 돈
        for k in 0...j { // 회사 선택한 돈
            let value = dp[i-1][j-k] + lists[k][i]
            if dp[i][j] < value {
                dp[i][j] = value
                cache[i][j] = k//주어진 돈 최대 j일 때 특정기업 i 투자비용 k원
            }
        }
    }
}
res += "\(dp[m][n])\n"
var ans: [Int] = []
var index = m // max투자금액
var cost = n
while index > 0 {
    let res = cache[index][cost]
    ans.append(res)
    cost -= res
    index -= 1
}
print(res+ans.reversed().map{String($0)}.joined(separator: " "))


