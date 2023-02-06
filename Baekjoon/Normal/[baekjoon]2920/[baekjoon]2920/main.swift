//
//  main.swift
//  [baekjoon]2920
//
//  Created by 양승현 on 2023/02/06.
//

/// 난 문제를 왜 이렇게 풀었을까??
/// "1 2 3 4 5 6 7 8" or "8 7 6 5 4 3 2 1"로 비교해서 풀면 더 쉬웠을 것인데,,

import Foundation

enum State: String {
    case ascending, descending, mixed
}

func isSameScale(_ pattern: [Int]) -> Bool {
    for i in arr {
        if pattern[i-1] != i {
            return false
        }
    }
    return true
}

func solution(_ pattern: inout [Int],
              _ answer: @escaping (State) ->Void){
    if arr.first! == pattern.first! && isSameScale(pattern) {
        answer(.ascending)
        return
    }
    pattern.reverse()
    guard !isSameScale(pattern) else{
        answer(.descending)
        return
    }
    answer(.mixed)
}

let arr = [1,2,3,4,5,6,7,8]
var input = readLine()!.split{$0==" "}.map{Int(String($0))!}

solution(&input) {
    print($0)
}

