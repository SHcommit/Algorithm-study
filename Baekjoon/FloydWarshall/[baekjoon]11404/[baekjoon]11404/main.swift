//
//  main.swift
//  [baekjoon]11404
//
//  Created by 양승현 on 2023/01/10.
//

import Foundation
/*
    대박 같은 경로인데 cost만 다르게 해서 또 주어질 수 있다고 나올 수도 있다.
 */
let vCnt = Int(readLine()!)!
let eCnt = Int(readLine()!)!
var visited = Array(repeating: Array(repeating: Int.max, count: vCnt), count: vCnt)
for i in 0..<vCnt { visited[i][i] = 0 }
(0..<eCnt).forEach { _ in
    let input = readLine()!.split{$0==" "}.map{Int(String($0))!}
    let (s,e,c) = (input[0]-1,input[1]-1,input[2])
    visited[s][e] = min(c,visited[s][e])
}
for k in 0..<vCnt {
    for v in 0..<vCnt {
        for w in 0..<vCnt {
            if visited[v][k] == Int.max || visited[k][w] == Int.max {
                continue
            }
            visited[v][w] = min(visited[v][w], visited[v][k]+visited[k][w])
        }
    }
}
visited.forEach{print($0.reduce(""){"\($0)\($1==Int.max ? 0 : $1) "})}
