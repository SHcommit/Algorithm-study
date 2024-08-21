//
//  main.swift
//  파괴되지 않은 건물
//
//  Created by 양승현 on 8/20/24.
//

import Foundation

/// 이 문제는 skill은 250,000 회반복해야하고, 최악의 경우 매번 board를 1,000 * 1,000 = 1,000,000 번의 연산을 250,000씩 반복해야한다...
///
/// 결국엔 스킬의 특정 범위가 주어질 때 board의 특정 영역을 이중 루프로해서 탐색하지 않고... 이 시간을 O(1)로 줄여야하는 방법을 찾아야했다.
///
/// 떠오르지 않았는데..  https://www.youtube.com/watch?v=siFY6UBHNgU&t=1128s 이분이 자세히 주셨다
/// 대박.. 이것이다..
///
/// 누적합을 단순히 더해가는게 아니라.. 누적합을 극도로 활용한 방법을 알 수있다.
/// 누적합 배열을 만들기 위해선, 주어진 영역만큼 계속해서 치유 or 어택을 갱신해나가야한다.
///
/// 그러나 지금 구현한 이 방식은 대박이다... detal 배열을 통해서, 누적합 배열을 매번 전 원소 갱신해나가는게 아니라 시작과 그 끝 +1 지점만 갱신을 반복한 후에,
/// 모든 skill이 끝날 경우에만 누적합을 진행한다.......
func solution(_ board:[[Int]], _ skill:[[Int]]) -> Int {
  var delta = Array(repeating: Array(repeating: 0, count: board[0].count+1), count: board.count+1)
  skill.forEach {
    let type = $0[0] == 1 ? -1: 1, y1 = $0[1], x1 = $0[2], y2 = $0[3], x2 = $0[4], degree = $0[5] * type
    delta[y1][x1] += degree
    delta[y1][x2+1] -= degree
    delta[y2+1][x1] -= degree
    delta[y2+1][x2+1] += degree
  }
  for y in 0..<board.count {
    for x in 1..<board[0].count {
      delta[y][x] += delta[y][x-1]
    }
  }
  for x in 0..<board[0].count {
    for y in 1..<board.count {
      delta[y][x] += delta[y-1][x]
    }
  }

  
  var ans = 0
  for y in board.indices {
    for x in board[0].indices where board[y][x] + delta[y][x] > 0 {
      ans += 1
    }
  }
  return ans
}

print(solution([[5,5,5,5,5],[5,5,5,5,5],[5,5,5,5,5],[5,5,5,5,5]], [[1,0,0,3,4,4],[1,2,0,2,3,2],[2,1,0,3,1,2],[1,0,1,3,3,1]]))
