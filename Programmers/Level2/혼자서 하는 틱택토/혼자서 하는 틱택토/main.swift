//
//  main.swift
//  혼자서 하는 틱택토
//
//  Created by 양승현 on 6/12/24.
//

import Foundation

/// 문제 접근 방식은 다음과 같음.
/// O개수 X개수를 전체 구해, 그리고 가로, 세로, 대각선 별로 O가 3개인지, X가 3개인지도 구해.
///
/// 1. O가 X보다 개수가 적으면 무저건 땡
/// 2. O가 X와 같을때 3개 이하면 무조건 정상적인 경기.'
///   2-1.  X가 3개일 때 무저건 안됨! 처리했는데
///     이게 문제였다. X가 3개여도 4개일때 승리할 수 있는 경우는 존재한다. 이 경우를 추가해줘야했다.
///   2-2. O가 3개일때 땡(X는 2개여야하는데 같기 X가 O가끝난지 모르고 또 뒀기 때문)
///   2-3. 이외의 경우 전부 정상적인 경기
/// 3. O가 더 많은 경우 O - X 개수가 1개일 때 이떄 X가 연이어 3개 놓인 경우가 아니면 다 가능한 경우.
///
///
/// 내가 실수한 부분은, 9개 놓으면 전부 0으로 처리했지만, 정상적으로 경기가 끝날수있는것 -> 1로 봤어야했고,
/// O, X 개수가 3개로 같을 때 아니면 4개일 때 무저건 X가 연이어 3개 놓이면 될 수 없는 경기로 뒀는데, x가 이기는 경우도 생각했어야 했다.... 
var board: [[String]] = []
func solution(_ inputBoard:[String]) -> Int {
  var ox: [Int] = [0, 0]
  inputBoard.forEach { line in
    line.forEach { c in
      if c == "O" { ox[0] += 1 }
      else if c == "X" { ox[1] += 1 }
    }
  }
  board = inputBoard.map { $0.map { String($0) } }

  let hasOGoal = hasGoal("O")
  let hasXGoal = hasGoal("X")
  if ox[0] < ox[1] {
    return 0
  } else if ox[0] == ox[1] {
    if ox[0] < 3 { return 1 }
    if hasXGoal {
      /// 아.. ㅠ X가 이기는 경우가 있었따...
      /// 경우의 수 하나 못찾는다고 .. 그게 크네..
      if !hasOGoal { return 1 }
      return 0
    } else if hasOGoal {
      return 0
    } else {
      return 1
    }
  } else {
    if ox[0] - ox[1] == 1 {
      if hasXGoal {
        return 0
      }
      return 1
    }
    return 0
  }
}

func hasGoal(_ target: String) -> Bool {
  var hasGoal = false
  board.forEach {
    if $0.filter({ $0 == target }).count == 3 {
      hasGoal = true
    }
  }
  for x in 0..<3 {
    if board[0][x] == target && board[1][x] == target && board[2][x] == target {
      hasGoal = true
    }
  }
  if board[0][0] == target && board[1][1] == target && board[2][2] == target {
    hasGoal = true
  }
  if board[0][2] == target && board[1][1] == target && board[2][0] == target {
    hasGoal = true
  }
  return hasGoal
}

/// 아.. X가 이긴다는 것은 생각 못하고 O에 너무 초점이 맞춰져있었다.;;
print(solution(["XO.",
                "OXO",
                "XOX"]))


