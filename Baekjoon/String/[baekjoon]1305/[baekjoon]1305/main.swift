//
//  main.swift
//  [baekjoon]1305
//
//  Created by 양승현 on 2023/01/27.
//

import Foundation

func getPartialMatch(n: [String])-> [Int] {
    var pi = Array(repeating: 0, count: n.count)
    var begin = 1, matched = 0
    while begin + matched < n.count {
        if n[begin+matched] == n[matched] {
            matched += 1
            pi[begin+matched-1] += matched
        }else {
            if matched == 0 {
                begin += 1
            } else {
                begin += matched - pi[matched-1]
                matched = pi[matched-1]
            }
        }
    }
    return pi
}

var n = Int(readLine()!)!
var text = readLine()!.map{String($0)}
var ad = [String]()
_=(0..<n).map{ i in
    ad.append(text[i%text.count])
}
let pi = getPartialMatch(n: ad)
print(n - pi[n-1])
