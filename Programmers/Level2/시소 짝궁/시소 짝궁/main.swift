//
//  main.swift
//  시소 짝궁
//
//  Created by 양승현 on 6/18/24.
//

import Foundation

//extension Int {
//  func toInt64() -> Int64 {
//    return Int64(self)
//  }
//}
//
//let Distance: [Int] = [2,3,4]
//typealias Seat = (lw: Int, rw: Int)
//func solution(_ weights:[Int]) -> Int64 {
//  let seats: [Seat] = combi(with: weights)
//  return seats
//    .filter { isOptimalMate(for: $0) }
//    .count
//    .toInt64()
//}
//
//func isOptimalMate(for seat: Seat) -> Bool {
//  for leftDistance in Distance {
//    for rightDistance in Distance where seat.lw*leftDistance == seat.rw*rightDistance {
//      return true
//    }
//  }
//  return false
//}
//
//func combi(with weights: [Int]) -> [Seat] {
//  var seats: [Seat] = []
//  for i in weights.indices {
//    for j in i..<weights.count {
//      if i == j { continue }
//      seats.append((weights[i], weights[j]))
//    }
//  }
//  return seats
//}

let optimalRate = [(1,1),(2,1),(3,2),(4,3)]

// MARK: - 실패 1
//typealias Seat = (lw: Int, rw: Int)
//func solution(_ weights:[Int]) -> Int64 {
//  return combi(with: weights.sorted(by: <))
//    .filter { isOptimalMate(for: $0) }
//    .count
//    .toInt64()
//  
//}
//
//func combi(with weights: [Int]) -> [Seat] {
//  var seats: [Seat] = []
//  for i in weights.indices {
//    for j in i..<weights.count {
//      if i == j { continue }
//      seats.append((weights[i], weights[j]))
//    }
//  }
//  return seats
//}
//
//func isOptimalMate(for seat: Seat) -> Bool {
//  for rate in optimalRate where seat.lw*rate.0 == seat.rw*rate.1 { return true }
//  return false
//}
//
//extension Int {
//  func toInt64() -> Int64 {
//    return Int64(self)
//  }
//}

print(solution([100,180,360,100,270]))


// MARK: - 실패2
//let optimalRate = [(1,1),(2,1),(3,2),(4,3)]
//typealias Seat = (lw: Int, rw: Int)
//func solution(_ weights:[Int]) -> Int64 {
//  var ans: Int64 = 0
//  let weights = weights.sorted(by: <)
//  for i in weights.indices {
//    for j in i+1..<weights.count {
//      if i == j { continue }
//      if isOptimalMate(for :(weights[i], weights[j])) {
//        ans += 1
//      }
//    }
//  }
//  return ans
//}
//
//func isOptimalMate(for seat: Seat) -> Bool {
//  for rate in optimalRate where seat.lw*rate.0 == seat.rw*rate.1 { return true }
//  return false
//}

// MARK: - 3트

let Rate: [Double] = [2,2/3,3/4]
func solution(_ weights:[Int]) -> Int64 {
  /// 같은 몸무게 중첩시 +1 증가.
  let dict = weights.reduce(into: [Double: Int]()) { $0[Double($1), default: 0] += 1 }
  var ans = 0
  dict.keys.forEach {
    /// 큰
    guard let t = dict[$0] else { return }
    for r in Rate {
      /// 작
      if let s = dict[$0/r] { ans += t*s }
    }
    /// 같은 사람 수
    if t > 1 { ans += t * (t-1)/2 }
  }
  return Int64(ans)
}
