//
//  main.swift
//  [baekjoon]2096
//
//  Created by 양승현 on 2023/02/09.
//

import Foundation

var n = Int(readLine()!)!
var res = ""
var board = Array(repeating: [Int](), count: n)

func clearCache() -> [[Int]] {
    var temp = Array(repeating: Array(repeating: 0, count: 3), count: n)
    temp[0] = board[0]
    return temp
}

func input() {
    _=(0..<board.count).map{
        board[$0] = readLine()!.split{$0==" "}.map{Int(String($0))!}
    }
}

func solution() {
    input()
    var cache = clearCache()
    (1..<n).map {
        cache[$0][0] = max(cache[$0-1][0],cache[$0-1][1]) + board[$0][0]
        cache[$0][1] = max(cache[$0-1][0],cache[$0-1][1],cache[$0-1][2]) + board[$0][1]
        cache[$0][2] = max(cache[$0-1][1],cache[$0-1][2]) + board[$0][2]
    }
    res += "\(cache[n-1].max()!) "
    cache = clearCache()
    (1..<n).map {
        cache[$0][0] = min(cache[$0-1][0],cache[$0-1][1]) + board[$0][0]
        cache[$0][1] = min(cache[$0-1][0],cache[$0-1][1],cache[$0-1][2]) + board[$0][1]
        cache[$0][2] = min(cache[$0-1][1],cache[$0-1][2]) + board[$0][2]
    }
    print(res + "\(cache[n-1].min()!)")
}

solution()
