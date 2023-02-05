//
//  main.swift
//  [baekjoon]7575
//
//  Created by 양승현 on 2023/02/05.
//

import Foundation

//MARK: - Helpers
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
            }else{
                begin += matched - pi[matched-1]
                matched = pi[matched-1]
            }
        }
    }
    return pi
}

func kmpSearch(text: [String], needle: [String]) -> Bool {
    let pi = getPartialMatch(pattern: needle)
    var begin = 0, matched = 0
    while begin <= text.count - needle.count {
        if matched < needle.count && text[begin+matched] == needle[matched] {
            matched += 1
            if matched == needle.count {
                return true
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
    return false
}

func checkVirusInSpecificText(text: [String],
                              needle: [String],
                              idx: Int) -> Bool {
    if kmpSearch(text: text, needle: needle) {
        return true
    }else {
        let reversed = text.reversed().map{String($0)}
        if kmpSearch(text: reversed, needle: needle) {
            return true
        }else {
            return false
        }
    }
}

func checkVirus(_ virus: [String]) -> Bool {
    for i in 1..<texts.count {
        if !checkVirusInSpecificText(text: texts[i],
                                     needle: virus,
                                     idx: i) {
            return false
        }
    }
    return true
}

func solution() {
    for i in 0..<texts[0].count-k + 1 {
        let virus = texts.first!.dropFirst(i).prefix(k).map{String($0)}
        if checkVirus(virus) {
            return print("YES")
        }
    }
    print("NO")
}

//MARK: - Properties
var nk = readLine()!.split{$0==" "}.map{Int(String($0))!}
let n = nk[0], k = nk[1]
var texts = Array(repeating: [String](), count: n)
var res = 0

_=(0..<n).map{
    _=readLine()
    texts[$0] = readLine()!.split{$0==" "}.map{String($0)}
}

solution()
