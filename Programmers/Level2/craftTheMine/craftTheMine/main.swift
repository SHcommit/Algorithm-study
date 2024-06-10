//
//  main.swift
//  craftTheMine
//
//  Created by 양승현 on 6/7/24.
//

import Foundation

/// 마인은 다이아몬드, 철, 돌 곡괭이를 각각 0~ 5개 갖는다.
/// 광물 캘 때 피로도 소모.
/// 각 곡괭이는 종류 상관없이 광물 5개를 캔 후에 더이상 사용 불가.
///
/// [최소한의규칙]
/// - 사용가능한 곡괭이 아무거나 하나 선택 -> 광물 캔다
/// - 한 번 사용하기 시작한 곡괭이는 사용할 수 없을 떄까지 사용한다.
/// - 광물은 주어진 순서대만 캘 수 있다.
/// - 모든 광물 캐거나, 곡괭이 없을떄까지 캔다.
///
/// 즉, 곡괭이 하나 선택시 연속 5번! -> 다음 곡괭이 선택 -> 연속 5번.
///
/// 이때 최소한의 피로도를 반환하는 함수를 만 들어라./

/// pciks: 다이아, 아이론 , 스톤 곡괭이 수/ minerals는 다이아 철 돌.
///
/// 광물은 무저건 캘 수 있는데, 피로도가 많이 소모되는 것 뿐임.

/// 곡괭이 참조 index
let D = 0, I = 1, S = 2

//func solution(_ picks:[Int], _ minerals:[String]) -> Int {
//  /// 미네랄 5개씩 묶은 작업들
//  var tasks: [[Int]]  = []
//  var ans = 0
//  
//  /// 미네랄을 5묶음으로 묶습니다.
//  /// 한개의 곡괭이를 사용하는 순간 연속으로 5개의 미네랄을 캐야하기 때문입니다.
//  /// 이때 주의할건, picks 개수만큼만 묶어야함.
//  for (i, mineral) in minerals.enumerated() {
//    if i % 5 == 0 { tasks.append([0, 0, 0]) }
//    var mineralIdx = S
//    if mineral == "diamond" { mineralIdx = D }
//    else if mineral == "iron" { mineralIdx = I }
//    tasks[i/5][mineralIdx] += 1
//  }
//  
//  /// 곡괭이 개수가 1개라면 소팅하는 의미가 없습니다
//  /// 곡괭이가 최소 2개여야 미네랄 자원이 높은 5묶음에 대한 소팅이 유효합니다.
////  if picks.reduce(0, +) > 1 {
////    tasks = tasks.sorted {
////      if $0.
////      if $0.reduce(0, +) == 5, $1.reduce(0, +) == 5 {
////        if $0[D] == $1[D] { return $0[I] > $1[I] }
////        return $0[D] > $1[D]
////      }
////      return false
////    }
////  }
////  
//  if picks.reduce(0, +) > 1 {
//    var last: [Int]?
//    if tasks.last?.reduce(0, +) != 5 {
//      last = tasks.popLast()
//    }
//    tasks = tasks.sorted {
//      if $0[D] == $1[D] {
//        if $0[I] == $1[I] {
//          return $0[S] > $1[S]
//        } else {
//          return $0[I] > $1[I]
//        }
//      }
//      return $0[D] > $1[D]
//    }
//    if last != nil {
//      tasks.append(last!)
//    }
//  }
//  
//  var taskIdx = 0
//  for pickIndex in 0...2 where picks[pickIndex] > 0 {
//    for _ in stride(from: picks[pickIndex], to: 0, by: -1) {
//      if taskIdx >= tasks.count { break }
//      let task = tasks[taskIdx]
//      if pickIndex == D {
//        ans += 5
//      } else if pickIndex == I {
//        ans += task[D]*5 + task[I] + task[S]
//      } else {
//        ans += task[D]*25 + task[I]*5 + task[S]
//      }
//      taskIdx += 1
//    }
//  }
//  return ans
//}

///이것도 잘못됨
//print(solution(
//  [1, 0, 1], ["stone", "stone", "stone", "stone","stone",
//              "iron","iron","iron","iron","iron",
//              "diamond", "diamond", "diamond", "diamond", "diamond", "diamond"]))

/*
 잘못됨. 25나오는데 5 나와야함.
 var taskIdx = 0
 for pickIndex in 0...2 where picks[pickIndex] > 0 {
 for _ in stride(from: picks[pickIndex], to: 0, by: -1) {
 if taskIdx == tasks.count { break }
 if pickIndex == D {
 ans += 5
 } else if pickIndex == I {
 ans += sortedTasks[taskIdx][D]*5
 ans += sortedTasks[taskIdx][I]*1
 ans += sortedTasks[taskIdx][S]*1
 } else {
 ans += sortedTasks[taskIdx][D]*25
 ans += sortedTasks[taskIdx][I]*5
 ans += sortedTasks[taskIdx][S]*1
 }
 taskIdx += 1
 }
 }
 return ans
 }
 // 이때가 문제
 print(solution([0, 0, 1], ["stone", "stone", "stone", "stone", "stone",
 "iron", "iron", "iron", "iron", "iron",
 "diamond", "diamond"]))

 */

func availableMinerals(_ picks: [Int], _ minerals: [String]) -> [[Int]] {
  var tasks: [[Int]] = []
  for i in 0..<picks.reduce(0, +) {
    tasks.append([0,0,0])
    for j in 0..<5 {
      let mineralIdx = i*5+j
      var mineral = S
      if mineralIdx < minerals.count {
        if minerals[mineralIdx] == "diamond" { mineral = D }
        else if minerals[mineralIdx] == "iron" { mineral = I }
        tasks[i][mineral] += 1
      } else {
        return tasks
      }
    }
  }
  return tasks
}

func solution(_ picks:[Int], _ minerals:[String]) -> Int {
  /// 미네랄 5개씩 묶은 작업들
  var tasks: [[Int]]  = availableMinerals(picks, minerals)
  var ans = 0
  
  /// 곡괭이 개수가 1개라면 소팅하는 의미가 없습니다
  /// 곡괭이가 최소 2개여야 미네랄 자원이 높은 5묶음에 대한 소팅이 유효합니다.
  if picks.reduce(0, +) > 1 {
    tasks = tasks.sorted {
      if $0[D] == $1[D] {
        if $0[I] == $1[I] {
          return $0[S] > $1[S]
        } else {
          return $0[I] > $1[I]
        }
      }
      return $0[D] > $1[D]
    }
  }
  
  var taskIdx = 0
  for pickIndex in 0...2 where picks[pickIndex] > 0 {
    for _ in stride(from: picks[pickIndex], to: 0, by: -1) {
      if taskIdx >= tasks.count { break }
      let task = tasks[taskIdx]
      if pickIndex == D {
        ans += task[D] + task[I] + task[S]
      } else if pickIndex == I {
        ans += task[D]*5 + task[I] + task[S]
      } else {
        ans += task[D]*25 + task[I]*5 + task[S]
      }
      taskIdx += 1
    }
  }
  return ans
}

///이것도 잘못됨
print(solution(
  [1, 0, 1], ["stone", "stone", "stone", "stone", "stone", // 0 0 5 | 0 1 0
              "iron"]))

/// 이경우 가중치가 가장 높은 다이아 를 기준으로하면 , 무저건 5개가 더해진다. 이럼 안됌. 스팅된 것을 비교할 때는 가중치가 가장 낮은 스톤부터 비교해야지만, 다이아일 때
/// 가중치가 가장
