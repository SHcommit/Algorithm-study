//
//  main.swift
//  [baekjoon]11049
//
//  Created by 양승현 on 2023/01/07.
//

import Foundation

//MARK: - Model
struct Rect {
    let s: Int
    let e: Int
}

//MARK: - Properties
var n = 0
var dp = [[Int]]()
var list = [Rect]()

func input() {
    n = Int(readLine()!)!
    dp = Array(repeating: Array(repeating: 0 ,count:n+1), count: n+1)
    (0..<n).forEach { _ in
        let input = readLine()!.split{$0==" "}.map{Int(String($0))!}
        list.append(Rect(s: input[0], e: input[1]))
    }
}

func solution() {
    input()
    for i in 1..<n {
        for j in stride(from: 1, to: n, by: i) {
            dp[j][i+j] = Int.max
            for k in stride(from: j, to: i+j, by: 1) {
                dp[j][i+j] = min(dp[j][i+j], dp[j][k] + dp[k+1][i+j] + list[j-1].s*list[k-1].e*list[i+j-1].e)
            }
        }
    }
    print(dp[1][n])
}

solution()
