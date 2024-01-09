//
//  main.swift
//  [baekjoon]15652
//
//  Created by 양승현 on 1/9/24.
//

import Foundation

/*
 자연수 N과 M이 주어졌을 때, 아래 조건을 만족하는 길이가 M인 수열을 모두 구해라.
 
 1부터 N까지 자연수 중에서 M개를 고른 수열
 같은 수를 여러 번 골라도 된다.
 고른 수열은 비내림차순이어야 한다. ( 이전꺼보다 작지 않아야함 )
 길이가 K인 수열 A가 A1 ≤ A2 ≤ ... ≤ AK-1 ≤ AK를 만족하면, 비내림차순이라고 한다.
 
 입력
 첫째 줄에 자연수 N과 M이 주어진다. (1 ≤ M ≤ N ≤ 8)
 */

var n = 0, m = 0
_={n = $0[0]; m=$0[1]}(readLine()!.split{$0==" "}.map{Int(String($0))!})

func execute(_ seq: [String]) {
  if seq.count == m {
    print(seq.joined(separator: " "))
    return
  }
  for i in 1...n where Int(seq.last ?? "0")! <= i { execute(seq + [String(i)]) }
}
execute([])
