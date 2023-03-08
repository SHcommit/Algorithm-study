//
//  main.swift
//  [baekjoon]1106
//
//  Created by 양승현 on 2023/03/07.
//

import Foundation

var cn = readLine()!.split{$0==" "}.map{Int(String($0))!}
let (c,n) = (cn[0],cn[1])
var cache = Array(repeating:0, count:1000*100 + 1)
let items: [(cost: Int, client: Int)] = (1...n).map{ _ in
    let seq = readLine()!.split{$0==" "}.map{Int(String($0))!}
    return (seq[0],seq[1])
}
(1...n).map{
    for j in 1...1000*100 {
        if j - items[$0-1].cost >= 0 {
            cache[j] = max(cache[j], cache[j - items[$0-1].cost] + items[$0-1].client)
        }
    }
}
func solution() {
    for i in 0...cache.count where cache[i] >= c{
            print(i)
        return
    }
}
solution()
