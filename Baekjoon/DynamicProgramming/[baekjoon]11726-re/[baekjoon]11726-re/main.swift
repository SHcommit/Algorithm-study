//
//  main.swift
//  [baekjoon]11726-re
//
//  Created by 양승현 on 2023/05/20.
//

import Foundation

let mod = 1000000007
func solution(n: Int) -> Int {
  var cache = Array(repeating: 0, count: n+1)
  // 1부터 n까지 포문으로 탐색을 하면서 매번 탐색할 때의 값을 저장 후 배열로 반환
  return (1...n).map {
    if $0 == 1 { cache[$0] = 1 }
    else if $0 == 2 { cache[$0] = 2 }
    else { cache[$0] = (cache[$0-1] + cache[$0-2]) % mod }
    return cache[$0]
  }.last! // 반환된 배열 중 마지막 원소 반환
}

print(solution(n: Int(readLine()!)!))

