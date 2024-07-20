//
//  main.swift
//  순위 검색
//
//  Created by 양승현 on 7/20/24.
//

import Foundation
 
func combi(_ n: Int, _ r: Int) -> [[Int]] {
  var res: [[Int]] = []
  
  func _combi(_ start: Int, seq: [Int]) {
    if seq.count == r {
      res.append(seq)
      return
    }
    
    for i in start..<n {
      _combi(i+1, seq: seq + [i])
    }
  }
  _combi(0, seq: [])
  return res
}

func solution(_ info:[String], _ iQuery:[String]) -> [Int] {
  let infoCnt = info.count
  var query = iQuery.map { $0.replacingOccurrences(of: " and ", with: " ").split{$0==" "} }
  let queryScores = query.indices.map { query[$0].removeLast() }
  let nC1 = combi(4,1), nC2 = combi(4,2), nC3 = combi(4,3), nC4 = combi(4,4)
  let availableArray: [[Int]] = nC1 + nC2 + nC3 + nC4
  
  let candidates = info.reduce(into: [String: [String: Int]]()) { d, candidate in
    var arr = candidate.split{$0==" "}.map { String($0) }
    let score = arr.removeLast()
    let key = arr.joined(separator: " ")
    
    if let _ = d[key] {
      d[key]![score, default: 0] += 1
    } else {
      d[key] = [score: 1]
    }
    let anotherKeys: [String] = availableArray.map { seq in
      var tmp = arr
      for idx in seq {
        tmp[idx] = "-"
      }
      return tmp.joined(separator: " ")
    }
    anotherKeys.forEach { anotherKey in
      if d[anotherKey] == nil {
        d[anotherKey] = [score:1]
      }else {
        d[anotherKey]![score, default: 0] += 1
      }
    }
  }
  
  // 언어 : 0. 직군 : 1. 경력 : 2, 음식 : 3. 스코어 : 4
  return query.indices.map { i in
    let score = queryScores[i]
    if score == "-" {
      return infoCnt
    }
    let key = query[i].joined(separator: " ")
    if let candidateAggregate = candidates[key] {
      var ans = 0
      candidateAggregate.keys.forEach { k in
        if Int(k) ?? -2 >= Int(score) ?? -1 {
          ans += candidateAggregate[k] ?? 0
        }
      }
      return ans
    }
    return 0
  }
}

print(solution(["java backend junior pizza 150"], ["- and - and - and - 151","- and - and - and - 150"]))
