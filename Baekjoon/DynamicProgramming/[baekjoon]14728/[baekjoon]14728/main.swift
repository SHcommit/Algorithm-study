//
//  main.swift
//  [baekjoon]14728
//
//  Created by 양승현 on 2023/03/05.
//

import Foundation
typealias Element = (time: Int, value: Int)
let nk = readLine()!.split{$0==" "}.map{Int(String($0))!}
let n = nk[0],k = nk[1]
var cache = Array(repeating: Array(repeating: 0, count: k+1), count: n+1)
var items: [Element] = (0..<n).map{ _ in
    let input = readLine()!.split{$0==" "}.map{Int(String($0))!}
    return (input[0],input[1])
}
(1...n).map{
    for j in (0...k) {
        cache[$0][j] = cache[$0-1][j]
        if j-items[$0-1].time >= 0 {
            cache[$0][j] = max(cache[$0-1][j - items[$0-1].time] + items[$0-1].value, cache[$0-1][j])
        }
    }
}
print(cache[n][k])
