//
//  main.swift
//  [baekjoon]Cubeditor
//
//  Created by 양승현 on 2023/01/28.
//

import Foundation

/// PS일지.
/// kmp의 pi배열은 prefix == suffix를 찾고 최적의 시작위치를 정하기 쉬운 전처리? 배열이다.
/// 중요한것은 prefix == suffix이라는 것은 같은 substring이 두번 연속 나온다는 것이다. 근데 문제는 계속 틀렸다 ㅋㅋ,,
/// 알고보니 abbcbba 같은 경우 prefix==suffix는 a. 1이다.
/// 근데 이 문제에선 문자열 내에서 !! 즉 a를 제외한 문자열 내에서 2개 이상 일치하는 substring 또한
/// 답이 될 수 있다.
/// kmp 알고리즘의 경우 prefix == suffix의 경우는 prefix == pattern 의 첫 문자열부터에 해당되기에 이문제를 풀 땐 예외 사항을 알아야하는데 참 .. ㅠㅅㅠ 2일정도 고민했는데 알게 됬다.

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
    let substring = pattern.suffix(pattern.count-$0).map{$0}
    let pi = getPartialMatch(needle: substring)
    res = max(res,pi.max()!)
}
print(res)
