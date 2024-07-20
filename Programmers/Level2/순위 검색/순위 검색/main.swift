//
//  main.swift
//  순위 검색
//
//  Created by 양승현 on 7/20/24.
//

import Foundation

/// 첫 트라이
/// 조합으로 키벨류값 전부 만들고,
///
/// 키의 값으로[Score: Count] 느낌으로 score마다 여러개 동일한 값이 있을수있기에 딕셔너리로했는데
/// 이럼 단점이 나중에 query에서 일정 숫자보다 클 경우 O(n)번 비교해야함.
/// ->[String: [String: Int]] // [키: [score: count]]
///
/// 이진탐색쓰면 O(logn)이긴한데 그래서 score중복된것도 그 스코어를 키로하고 중복된것을 값으로 말고
/// 중복된것들 그냥 일차원배열에 다 넣는것으로 변경
/// -> [String: [Int]
///

/// 효율성 체크를 첨 만나봤는데
/// 큰거 찾는거일때는 O(nm)나오게 하지말고 O(nlogm)나오게 하자.-> 이진탐색으로 특정 크기 이상으로 찾기.
///
/// 그리고 한번 생성되는 루프를 잘 활용하자.
/// let a = ... .map()
/// let b = a.map ()
/// 이렇게 해야하는경우도 있는데 그렇지 않으면 a 공간 안에서 처리 해보자!
 
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

func bs(target: Int, _ seq: [Int]) -> Int {
  var l = 0, r = seq.count, m = 0
  while l<r {
    m = (l+r)/2
    if seq[m] >= target {
      r = m
    } else {
      l = m+1
    }
  }
  return seq.count - l
}

func solution(_ info:[String], _ iQuery:[String]) -> [Int] {
  let infoCnt = info.count
  var query = iQuery.map { $0.replacingOccurrences(of: " and ", with: " ").split{$0==" "} }
  let queryScores = query.indices.map { query[$0].removeLast() }
  let nC1 = combi(4,1), nC2 = combi(4,2), nC3 = combi(4,3), nC4 = combi(4,4)
  let availableArray: [[Int]] = nC1 + nC2 + nC3 + nC4
  
  var candidates = info.reduce(into: [String:[Int]]()) { d, candidate in
    var arr = candidate.split{$0==" "}.map { String($0) }
    let score = Int(arr.removeLast())!
    let key = arr.joined(separator: " ")
    if d[key] == nil {
      d[key] = []
    }
    d[key]?.append(score)
    
    availableArray.forEach { seq in
      var tmp = arr
      for idx in seq {
        tmp[idx] = "-"
      }
      let anotherKey = tmp.joined(separator: " ")
      if d[anotherKey] == nil {
        d[anotherKey] = []
      }
      d[anotherKey]?.append(score)
    }
  }
  
  for key in candidates.keys {
    candidates[key]?.sort()
  }
  
  // 언어 : 0. 직군 : 1. 경력 : 2, 음식 : 3. 스코어 : 4
  return query.indices.map { i in
    let score = queryScores[i]
    if score == "-" {
      return infoCnt
    }
    let key = query[i].joined(separator: " ")
    
    if let candidateAggregate = candidates[key] {
      return bs(target: Int(score) ?? 0, candidateAggregate)
    }
    return 0
  }
}

print(solution(["java backend junior pizza 150","python frontend senior chicken 210","python frontend senior chicken 150","cpp backend senior pizza 260","java backend junior chicken 80","python backend senior chicken 50"], ["java and backend and junior and pizza 100","python and frontend and senior and chicken 200","cpp and - and senior and pizza 250","- and backend and senior and - 150","- and - and - and chicken 100","- and - and - and - 150"]))


/// ## [ 1st try ]
func solution1(_ info:[String], _ iQuery:[String]) -> [Int] {
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
