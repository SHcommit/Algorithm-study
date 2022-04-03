//
//  main.swift
//  [baekjoon]2293
//
//  Created by 양승현 on 2022/04/03.
//
/**
 * 이 문제는 c++로 풀었을 때 맞았는데, swift로는 계속 오류가 발생했다.
 * 특정 dp[]값이 Int범위를 초과하기 때문에 에러가 발생된다고 한다..ㅠㅠ
 */
import Foundation
let nk = readLine()!.split(separator: " ").map{Int($0)!}
//n == 동전 개수 , k == 돈
var n = nk[0] , k = nk[1]
var dp = Array(repeating: 0, count: nk[1]+1);dp[0] = 1;
for _ in 0..<n{
    let coin = Int(readLine()!)!
    if coin > k{ continue }
    for j in coin...k{
        dp[j] += dp[j - coin]
        if dp[j] > 2147483648 { dp[j] = 0 }
    }
    
}
print(dp[k])

