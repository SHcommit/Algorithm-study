//
//  main.swift
//  [baekjoon]17845
//
//  Created by 양승현 on 2023/03/06.
//

import Foundation

var nk = readLine()!.split{$0==" "}.map{Int(String($0))!}
let lists: [(priority: Int, time: Int)] = (0..<nk[1]).map{_ in
    let n = readLine()!.split{$0==" "}.map{Int(String($0))!}
    return (n[0],n[1])
}
var cache = Array(repeating: Array(repeating: 0, count: nk[0]+1), count: nk[1]+1)
for i in 1...nk[1] {
    for j in 1...nk[0] {
        if j - lists[i-1].time >= 0 {
            cache[i][j] = max(cache[i-1][j],
                              cache[i-1][j-lists[i-1].time] + lists[i-1].priority)
        }else {
            cache[i][j] = cache[i-1][j]
        }
    }
}
print(cache[nk[1]][nk[0]])
