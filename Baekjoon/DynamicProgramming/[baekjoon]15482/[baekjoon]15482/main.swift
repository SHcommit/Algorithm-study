//
//  main.swift
//  [baekjoon]15482
//
//  Created by 양승현 on 2023/02/21.
//

import Foundation

let s1 = readLine()!.map{UnicodeScalar(String($0))!.value}
let s2 = readLine()!.map{UnicodeScalar(String($0))!.value}
var cache = Array(repeating:Array(repeating: 0, count: s2.count+1), count: s1.count+1)
(1...s1.count).map{ i in
    (1...s2.count).map{
        if s1[i-1]==s2[$0-1] {
            cache[i][$0] = cache[i-1][$0-1]+1
        }else {
            cache[i][$0] = max(cache[i-1][$0],cache[i][$0-1])
        }
    }
}
print(cache[s1.count][s2.count])
