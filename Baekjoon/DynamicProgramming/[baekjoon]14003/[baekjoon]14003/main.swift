//
//  main.swift
//  [baekjoon]14003
//
//  Created by 양승현 on 2023/02/19.
//

import Foundation

//https://dev-with-precious-dreams.tistory.com/197

//MARK: - Properties
_=readLine()
let lists = readLine()!.split{$0==" "}.map{Int(String($0))!}
var sequence = [lists.first!]
var dp = Array(repeating: 1, count: lists.count)

//MARK: - Helpers
func binarySearch(_ seq: inout [Int], target: Int) -> Int {
    var left = 0,right = seq.count-1,mid=0
    while left<right {
        mid = (left+right)/2
        if target>seq[mid] {
            left = mid + 1
        }else {
            right = mid
        }
    }
    seq[right] = target
    return right
}
func lis() {
    (1..<lists.count).map{
        if lists[$0] > sequence.last! {
            sequence.append(lists[$0])
            dp[$0] = sequence.count
        }else {
            let idx = binarySearch(&sequence, target: lists[$0]) + 1
            dp[$0] = idx
        }
    }
}
func backtracking() -> [Int] {
    var length = dp.max()!
    var res: [Int] = []
    for i in stride(from: lists.count-1, through: 0, by: -1) where dp[i] == length {
        res.append(lists[i])
        length -= 1
    }
    return res.reversed()
}

func solution() {
    lis()
    let sequence = backtracking()
    print(sequence.count)
    print(sequence
        .map{String($0)}
        .joined(separator: " "))
}

solution()
