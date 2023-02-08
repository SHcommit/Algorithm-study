//
//  main.swift
//  [baekjoon]9084
//
//  Created by 양승현 on 2023/02/08.
//

import Foundation
_=(0..<Int(readLine()!)!).map {_ in
    _=Int(readLine()!)!
    let items = readLine()!.split{$0==" "}.map{Int(String($0))!}
    let money = Int(readLine()!)!
    var cache = Array(repeating: 0,count: money + 1)
    cache[0] = 1
    for item in items {
        if item > money {continue}
        _=(item...money).map{
            cache[$0] = cache[$0] + cache[$0-item]
        }
    }
    print("\(cache[money])")
}
