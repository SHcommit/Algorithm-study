//
//  main.swift
//  [baekjoon]14002
//
//  Created by 양승현 on 2023/02/18.
//

// solution1은 O(n^2)의 풀이.
// solution2는 O(nlogn)의 풀이.
// https://dev-with-precious-dreams.tistory.com/194

import Foundation

//MARK: - Properties
let n = Int(readLine()!)!
let list = readLine()!.split{$0==" "}.map{Int(String($0))!}
var res = [Int]()

//MARK: - Helpers
func lis(dp: inout [Int]) {
    (1..<n).map{
        for j in 0..<$0 where list[$0] > list[j] {
            dp[$0] = max(dp[$0],dp[j]+1)
        }
    }
}

func backtracking(dp: [Int]) {
    var length = dp.max()!
    for i in stride(from: n-1, through: 0, by: -1) where dp[i] == length {
        res.append(list[i])
        length-=1
    }
}
func solution() {
    var dp = Array(repeating: 1, count: n+1)
    
    lis(dp: &dp)
    backtracking(dp: dp)
    print(dp.max()!)
    print(res.reversed().map{String($0)}.joined(separator:" "))
}

//solution()
solution2()

func solution2() {
    var seq = [list[0]]
    var dp = Array(repeating: 1, count: n)
    for i in 1..<n {
        if list[i] > seq.last! {
            seq.append(list[i])
            dp[i] = seq.count
        }else {
            let idx = binarySearch(&seq, list[i])
            dp[i] = idx + 1
        }
    }
    backtracking(dp: dp)
    print(dp.max()!)
    print(res.reversed().map{String($0)}.joined(separator:" "))
    
}

func binarySearch(_ seq: inout [Int], _ target: Int) -> Int {
    var left = 0, right = seq.count - 1
    while left < right {
        let mid = (left+right)/2
        if target > seq[mid] {
            left = mid + 1
        }else {
            right = mid
        }
    }
    seq[right] = target
    return right
}
