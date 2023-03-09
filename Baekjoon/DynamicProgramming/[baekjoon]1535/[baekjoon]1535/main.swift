//
//  main.swift
//  [baekjoon]1535
//
//  Created by 양승현 on 2023/03/09.
//

import Foundation

let n = Int(readLine()!)!
var l = readLine()!.split{$0==" "}.map{Int(String($0))!}
var j = readLine()!.split{$0==" "}.map{Int(String($0))!}
var cache = Array(repeating: 0, count: 101)
for i in 1...n {
    for e in stride(from: 100, through: 1, by: -1) {
        cache[e] = cache[e]
        if e - l[i-1] > 0 {
            cache[e] = max(cache[e],cache[e-l[i-1]] + j[i-1])
        }
    }
}
print(cache[100])
