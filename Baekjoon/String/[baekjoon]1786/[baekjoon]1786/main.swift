//
//  main.swift
//  [baekjoon]1786
//
//  Created by 양승현 on 2023/01/25.
//

import Foundation

var text = readLine()!.map{String($0)}
var pattern = readLine()!.map{String($0)}
var res: [Int] = []

///pattern에 대해서 찾는거 왜? text의 substring == pattern마지막 -1 인 경우엔 pattern의 substring
///과 text의 substring이 같기 때문이다. 결국엔 pattern에서 접미사이자 접두사인 + 최대 길이를 찾으면 됨;;ㄷㄷ
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

///KMP
func kmpSearch() {
    let pi = getPartialMatch(n: pattern)
    var begin = 0, matched = 0
    while begin <= text.count - pattern.count {
        if matched<pattern.count && text[begin+matched] == pattern[matched] {
            matched += 1
            if matched == pattern.count {
                res.append(begin)
            }
        }else {
            if matched == 0 {
                begin += 1
            }else {
                begin += matched - pi[matched-1]
                matched = pi[matched-1]
            }
        }
    }
}
kmpSearch()

print("\(res.count)\n\(res.map{String($0+1)}.joined(separator: " "))")
