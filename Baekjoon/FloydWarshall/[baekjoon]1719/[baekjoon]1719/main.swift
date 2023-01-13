//
//  main.swift
//  [baekjoon]1719
//
//  Created by 양승현 on 2023/01/13.
//

import Foundation

/**
    이번 문제는 플로이드 와샬을 이용하는데 cost가 아니라 특정 구간을 갈때 거쳐야 하는 최소한의 정점을 기록하는 문제를 풀었다!   
 
 */

var ve = readLine()!.split{$0==" "}.map{Int(String($0))!}
let (nCnt,eCnt) = (ve[0],ve[1])
var visited = Array(repeating: Array(repeating: Int.max, count: nCnt), count: nCnt)
var graph = Array(repeating: Array(repeating: -1, count: nCnt), count: nCnt)
var idx = 0
for y in 0..<nCnt {
    visited[y][idx] = 0
    idx += 1
}
_=(0..<eCnt).map {  _ in
    let input = readLine()!.split{$0==" "}.map{Int(String($0))!}
    let (s,e,c) = (input[0]-1,input[1]-1,input[2])
    graph[s][e] = e
    graph[e][s] = s
    visited[s][e] = c
    visited[e][s] = c
}
for k in 0..<nCnt {
    for v in 0..<nCnt {
        for w in 0..<nCnt {
            if visited[v][k] == Int.max || visited[k][w] == Int.max { continue }
            if visited[v][w] > visited[v][k] + visited[k][w] {
                visited[v][w] = visited[v][k] + visited[k][w]
                graph[v][w] = graph[v][k]
            }
        }
    }
}

_=graph.map{
    print($0.map{$0 == -1 ? String("-"):String($0+1)}.reduce(""){"\($0)\($1) "})
}
