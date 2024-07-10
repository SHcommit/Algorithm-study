//
//  main.swift
//  피로도
//
//  Created by 양승현 on 7/10/24.
//

import Foundation

/// 비트마스킹+ 순열로 브루트 포스 느낌으로 풀어봤다.
/// 새로 알게된 점은 visited & (1<<i) 를 할 때 해당 특정 비트의 연산 결과는 1 or 0이 아니라 0 or 1이상이 될 수 있다는 점. 1이상인 경우에 해당 비트가
/// 사용 된다는점
func solution(_ k:Int, _ dungeons:[[Int]]) -> Int {
  let dN = dungeons.count
  var res = 0
  var visited: UInt = 0b00000000
  var perm: [[Int]] = []
  
  func permutation(_ arr: [Int]=[]) {
    if arr.count == dN {
      perm.append(arr)
      return
    }
    
    for i in dungeons.indices {
      if visited & (1<<i) != 0 { continue }
      visited |= (1<<i)
      permutation(arr + [i])
      visited &= ~(1<<i)
    }
  }
  permutation()
  
  for p in perm {
    var k = k, tmpRes = 0
    let dungeon = p.map { dungeons[$0] }
    for d in dungeon {
      if d[0] > k { break }
      k-=d[1]
      tmpRes+=1
    }
    res = max(res, tmpRes)
  }
  return res
}

print(solution(80, [[80,20],[50,40],[30,10]]))
