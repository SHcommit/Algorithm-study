//
//  main.swift
//  [baekjoon]1958
//
//  Created by 양승현 on 2023/02/21.
//

import Foundation

let s1 = readLine()!.map{String($0)}
let s2 = readLine()!.map{String($0)}
let s3 = readLine()!.map{String($0)}
var cache = Array(repeating: Array(repeating: Array(repeating: 0, count: s3.count+1), count: s2.count+1), count: s1.count+1)
func solution() {
    defer{print(cache[s1.count][s2.count][s3.count])}
    (1...s1.count).map { i in
        (1...s2.count).map {j in
            (1...s3.count).map { k in
                if s1[i-1] == s2[j-1] && s2[j-1] == s3[k-1] {
                    cache[i][j][k] = cache[i-1][j-1][k-1]+1
                }else {
                    cache[i][j][k] = max(cache[i-1][j][k],cache[i][j-1][k],cache[i][j][k-1])
                }
            }
        }
    }
}
solution()
