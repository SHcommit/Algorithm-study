//
//  main.swift
//  [baekjoon]2568
//
//  Created by 양승현 on 2023/02/19.
//

//https://dev-with-precious-dreams.tistory.com/191

import Foundation

//MARK: - Properteis
var lists: [Cable] = []
(0..<Int(readLine()!)!).map{ _ in
    let input = readLine()!.split{$0==" "}.map{Int(String($0))!}
    lists.append(Cable(left: input[0], right: input[1]))
}

//MARK: - Models
struct Cable {
    let left: Int
    let right: Int
}
extension Cable: Comparable {
    static func <(lhs:Cable,rhs:Cable) -> Bool {
        return lhs.right < rhs.right
    }
}

//MARK: - Helpers
func binarySearch(_ seq: inout [Int],_ target: Int) -> Int {
    var l = 0, r = seq.count-1, mid = 0
    while l<r {
        mid = (l+r)/2
        if target > seq[mid] {
            l = mid + 1
        }else {
            r = mid
        }
    }
    seq[r] = target
    return r
}

func backtracking(_ dp: [Int]) -> [Int] {
    var target = dp.max()!
    var sequence: [Int] = []
    
    for i in stride(from: dp.count-1, through: 0, by: -1) where dp[i] == target {
        sequence.append(lists[i].left)
        target -= 1
    }
    
    return lists
        .map { $0.left }
        .filter{ !sequence.contains($0)}
        .sorted()
}

func solution() {
    lists.sort()
    let n = lists.count
    var subsequence = [lists.first!.left]
    var dp = Array(repeating: 1, count: n)
    (1..<n).map{
        if lists[$0].left > subsequence.last! {
            subsequence.append(lists[$0].left)
            dp[$0] = subsequence.count
        }else {
            let idx =  binarySearch(&subsequence, lists[$0].left) + 1
            dp[$0] = idx
        }
    }
    let res = backtracking(dp)
    print(res.count)
    print(res.map{String($0)}.joined(separator:"\n"))
}

solution()
