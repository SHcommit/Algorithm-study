//
//  main.swift
//  후보키
//
//  Created by 양승현 on 8/11/24.
//

import Foundation

/// 1. 모든 attributes 조합을 찾는다
/// 2. 특정 키들이 유일한지 조합에서 선정된 키들에 대한 record의 값들이 레코드 개수와 같는지 비교.
/// - >  이때 처음에 set을 사용함. 그래서 반복문으로 모든 레코드 순차적으로 돌면서 집합에 넣었을 때 집합 개수와 record 총 개수가 일치할 때만
///     후보키에 해당되는지(최소성을 갖는지) 여부를 비교함.
///     set을 사용하면 결국 모든 레코드 다 집어넣는 연산을 해야해서 몇 테스트 케이스에서 시간초과가 났음.
///
///     -> 그래서 딕셔너리 사용해서 특정 키를 사용한 레코드가 이미 저장되었다면 다음 조합을 실행하도록함.
///
/// 3. 후보키들의 부분집합에 탐색중인 특정 조합이 포함된다면 해당 조합은 최소성을 만족하지 않음.
/// 4. 후보키들과 key가 일치하지 않는 combi(attr key 조합)은 후보키에 햅격임.
///
///
/// 위에 2번의 시간초과는 -> Set.update(with:) 를 사용한다면 해결할 수 있다.. 이게 더 편하다. 이거는 Set에 원소를 추가할 때 새로운 원소라면 nil,
///   기존에 존재하던 원소라면 기존 원소를 반환한다. ( not nil )

// MARK: - 2nd try
func solution(_ relation:[[String]]) -> Int {
  let numOfAttrs = relation[0].count
  let numOfTuples = relation.count
  var 후보키들 = [[Int]]()
  let numbers = (0..<numOfAttrs).map { $0 }
  let allCombi = (1...numOfAttrs).flatMap { count in
    numbers.combi(of:count)
  }
  
  for comb in allCombi {
    guard is유일성(comb: comb, relation: relation) else { continue }
    var is최소성 = true
    for 후보키 in 후보키들 {
      if Set(후보키).isSubset(of: Set(comb)) {
        is최소성 = false; break
      }
    }
    if is최소성 {
      후보키들.append(comb)
    }
  }
  
  return 후보키들.count
}

func is유일성(comb: [Int], relation: [[String]]) -> Bool {
  var projectionDict: [String: Bool] = [:]
  for tuple in relation {
    let projection = comb.map { tuple[$0] }.joined(separator: ",")
    guard projectionDict[projection] == nil else {
      return false
    }
    projectionDict[projection] = true
  }
  return true
}
extension Array {
  func combi(of count: Int) -> [[Element]] {
    if count == 0 { return [[]] }
    guard let first = first else { return [] }
    let subArr = Array(self[1..<endIndex])
    let withFirst = subArr.combi(of: count-1).map { [first] + $0 }
    let withoutFirst = subArr.combi(of: count)
    return withFirst + withoutFirst
  }
}


// MARK: - 1트. 몇 테스트케이스 시간초과
//func solution(_ relation:[[String]]) -> Int {
//  let numOfAttrs = relation[0].count
//  let numOfTuples = relation.count
//  var 후보키들 = [[Int]]()
//  let numbers = (0..<numOfAttrs).map { $0 }
//  let allCombi = (1...numOfAttrs).flatMap { count in
//    numbers.combi(of:count)
//  }
//
//  for comb in allCombi {
//    var projectionSet = Set<String>()
//
//    for tuple in relation {
//      let projection = comb.map { String(tuple[$0]) }.joined(separator: ",")
//      projectionSet.insert(projection)
//    }
//    guard projectionSet.count == numOfTuples else { continue }
//    var is최소성 = true
//    for 후보키 in 후보키들 {
//      if Set(후보키).isSubset(of: Set(comb)) {
//        is최소성 = false; break
//      }
//    }
//    if is최소성 {
//      후보키들.append(comb)
//    }
//  }
//
//  return 후보키들.count
//}



print(solution([["100","ryan","music","2"],["200","apeach","math","2"],["300","tube","computer","3"],["400","con","computer","4"],["500","muzi","music","3"],["600","apeach","music","2"]]))
