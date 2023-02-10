//
//  main.swift
//  [baekjoon]4354
//
//  Created by 양승현 on 2023/02/10.
//

import Foundation

func getPartialMatch(pattern: [String]) -> [Int] {
    var pi = Array(repeating: 0, count: pattern.count)
    var begin = 1, matched = 0
    
    while begin + matched < pattern.count {
        if pattern[begin+matched] == pattern[matched] {
            matched += 1
            pi[begin+matched-1] = matched
        }else {
            if matched == 0 {
                begin += 1
            }else {
                begin += matched - pi[matched-1]
                matched = pi[matched-1]
            }
        }
    }
    return pi
}

func solution() {
    var res = ""
    defer{ print(res) }
    while true {
        let text = readLine()!.map{String($0)}
        guard text.first != "." else { return }
        let pi = getPartialMatch(pattern: text)
        let prefix = text.count - pi.last!
        res += text.count % prefix == 0 ? "\(text.count/prefix)\n" : "1\n"
    }
}
solution()
