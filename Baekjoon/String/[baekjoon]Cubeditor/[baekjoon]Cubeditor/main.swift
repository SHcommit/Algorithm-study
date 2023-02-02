//
//  main.swift
//  [baekjoon]Cubeditor
//
//  Created by 양승현 on 2023/01/28.
//

import Foundation

func getPartialMatch(needle: [String]) -> [Int] {
    var pi = Array(repeating:0,count: needle.count)
    var begin = 1, matched = 0
    while begin + matched < needle.count {
        if needle[begin+matched] == needle[matched] {
            matched += 1
            pi[begin+matched-1] += matched
        } else {
            if matched == 0 {
                begin += 1
            }else{
                begin += matched - pi[matched-1]
                matched = pi[matched-1]
            }
        }
    }
    return pi
}

var pattern = readLine()!.map{String($0)}
var res = 0
_=(0..<pattern.count).map {
    let substring = pattern.prefix($0+1).map{$0}
    let pi = getPartialMatch(needle: substring)
    
}
print(res)
