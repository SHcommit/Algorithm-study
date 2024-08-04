//
//  main.swift
//  크레인 인형뽑기
//
//  Created by 양승현 on 8/5/24.
//

import Foundation

func solution(_ board:[[Int]], _ moves:[Int]) -> Int {
  let height = board.count
  var _board = board, stack: [Int] = [], ans = 0
  moves.forEach { move in
    for y in 0..<height {
      let item = _board[y][move-1]
      if item == 0 { continue }
      _board[y][move-1] = 0
      guard let last = stack.last, last == item else {
        stack.append(item); return
      }
      ans+=2
      _=stack.removeLast()
      return
    }
  }
  return ans
}

print(solution([[0,0,0,0,0],[0,0,1,0,3],[0,2,5,0,1],[4,2,4,4,2],[3,5,1,3,1]], [1,5,3,5,1,2,1,4]))
