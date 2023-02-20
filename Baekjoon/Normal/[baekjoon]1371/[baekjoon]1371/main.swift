//
//  main.swift
//  [baekjoon]1371
//
//  Created by 양승현 on 2023/02/21.
//

import Foundation

private typealias US = UnicodeScalar
func cToA(_ char: Character) -> Int {
    return Int(US.init(String(char))!.value) - Int(US.init(String("a"))!.value)
}
func aToC(_ idx: Int) -> String{
    return String(UnicodeScalar(97 + idx)!)
}

func solution() {
    var cache = Array(repeating: 0, count: cToA("z") - cToA("a") + 1)
    var res = ""
    defer {
        for i in 0..<cache.count where cache[i] == cache.max()! {
            res += aToC(i)
        }
        print(res)
    }
    while let str = readLine() {
        str.filter{$0 != " "}
            .map{cache[cToA($0)] += 1}
    }
}

solution()
