//
//  main.swift
//  연속 부분 수열 합의 개수
//
//  Created by 양승현 on 7/3/24.
//

import Foundation


// MARK: - 1트. 6번 테스트부터 time out
func solution1(_ elements:[Int]) -> Int {
  return Set((0..<elements.count).map { partialPermutation($0+1, elements: elements) }.flatMap { $0 }).count
}

func partialPermutation(_ numOfParts: Int, elements: [Int]) -> [Int] {
  let count = elements.count
  if numOfParts == count {
    return [(0..<count).reduce(0) { $0 + elements[$1] }]
  }
  return (0..<count).map { i in
    (0..<numOfParts).reduce(0) { $0 + elements[(i+$1)%count] }
  }
}

// MARK: - 2트. 시간복잡도를 O(n^2)로 줄여봄. 시간 초과.
/// 그리고 사실 이것도 reduce까지하면 O(n^3)임.
func solution2(_ elements: [Int]) -> Int {
  let ee = elements + elements
  let allCases = (1...elements.count).map { l in
    (0..<elements.count).map { s in
      ee[s..<s+l].reduce(0, +)
    }
  }
  return Set(allCases.flatMap { $0 }).count
}

// MARK: - 3트.. Swift에 한해서 누적합을 적용해야한다. reduce보다 빠른 구간합을 이용해야한다
/// 그렇구나.
/// s+l 를한다. 봐봐
/// 0 + 3을 하는건 3임. 근데 실질적으로 elements[0...2]를 해야함. prefixSums[3] = elements[0...2]합. ㅇㅇ
func solution(_ elements: [Int]) -> Int {
  let n = elements.count
  var prefixSums = [0] + elements
  for i in 1...n { prefixSums[i] += prefixSums[i-1] }
  
  let allCases = (1...n).map { l in
    (0..<n).map { s in
      let e = (s+l)%n
      return e > s ? prefixSums[e] - prefixSums[s] : prefixSums[n] - prefixSums[s] + prefixSums[e]
    }
  }
  return Set(allCases.flatMap { $0 }).count
}

print(solution([7,9,1,1,4]))
