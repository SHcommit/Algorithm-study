//
//  main.swift
//  [baekjoon]1083
//
//  Created by 양승현 on 2022/03/26.
//
/**
 * 5
 1 2 3 4 5
 4
 *  2 3 4 5 1
 *  근데 사실 답은 5 1.  2 3 4 래;;
 */

//그리디 문제?!

import Foundation

var n = Int(readLine()!)!
var seq = readLine()!.split(separator: " ").map{Int($0)!}
var swap = Int(readLine()!)!
var cnt = 0
var res = ""
for i in 0..<seq.count - 1 {
    if cnt != swap{
        if seq[i] < seq[i+1] {
            cnt += 1
            var tmp = seq[i]
            seq[i] = seq[i+1]
            seq[i+1] = tmp
        }
    }
}
for i in seq{
    res += "\(i) "
}
print(res)
