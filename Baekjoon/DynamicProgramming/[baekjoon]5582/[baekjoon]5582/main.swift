//
//  main.swift
//  [baekjoon]5582
//
//  Created by 양승현 on 2023/02/21.
//

//https://dev-with-precious-dreams.tistory.com/manage/posts/

import Foundation

func solution() {
    let str1 = readLine()!.map{String($0)}
    let str2 = readLine()!.map{String($0)}
    var cache = Array(repeating: Array(repeating: 0, count: str2.count+1), count: str1.count+1)
    var res = 0
    defer{ print("\(res)") }
    (1...str1.count).map{
        for j in 1...str2.count where str1[$0-1]==str2[j-1] {
            cache[$0][j] = cache[$0-1][j-1] + 1
            res = max(res,cache[$0][j])
        }
    }
}
solution()
