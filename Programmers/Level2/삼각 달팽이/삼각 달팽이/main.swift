//
//  main.swift
//  삼각 달팽이
//
//  Created by 양승현 on 8/3/24.
//

import Foundation

/// 난 이 문제 접근을.. 처음에 세모를 어떻게 표시할까 하다
/// 2차원 배열에서 저장하는게 어떨까 한번 그려봤는대 나름 패턴 유츄가 가능했음.
///
/// 1. 아래로 1씩 키운다. -> x == 0, y += 1이렇게증가.
/// 그러다가 outofBounds나 이미 구했다면
///
/// 2. 오른쪽으로 1 씩 키운다. -> x += 1, y == 0 이렇게 증가.
/// 그러다가 outOfBounds나 이미 구해진 것이라면
///
/// 3. 대각선 위로 증가해나간다. -> x -= 1, y -= 1이렇게 증가.
/// 그러다가 해당 대각선이 이미 구해진 것이라면
///   -> 아래는 한번도 구하지 않은 숫자인가? -> 아래로 direction바꿔나감.
///   else 전부다 탐색!
///
/// 2차원 배열 초기 탐색은 0으로 설정하고, 어차피 대각선 윗부분은 다 0이어서 flatMap -> filter해주면 끝!! 키야: ) 

typealias Point = (x: Int, y: Int)
let down = 0, right = 1, across = 2
func solution(_ n:Int) -> [Int] {
  if n == 1 { return [1] }
  else if n == 2 { return [1,2,3] }
  var ans = Array(repeating: Array(repeating: 0, count: n), count: n)
  ans[0][0] = 1
  var curP: Point = (0,0)
  var d = down
  while true {
    var tempP = curP
    if d == down {
      tempP = (curP.x, curP.y+1)
      if isOutOfBounds(tempP, n) || ans[tempP.y][tempP.x] > 0 {
        d = right
        continue
      }
    } else if d == right {
      tempP = (curP.x+1, curP.y)
      if isOutOfBounds(tempP, n) || ans[tempP.y][tempP.x] > 0 {
        d = across
        continue
      }
    } else {
      tempP = (curP.x-1, curP.y-1)
      if ans[tempP.y][tempP.x] > 0 {
        if ans[curP.y+1][curP.x] > 0 {
          break
        }
        d = down
        continue
      }
    }
    ans[tempP.y][tempP.x] = ans[curP.y][curP.x] + 1
    curP = tempP
  }
  
  return ans.flatMap { $0 }.filter { $0 != 0 }
}

func isOutOfBounds(_ p: Point, _ n: Int) -> Bool {
  !((0..<n)~=p.x && (0..<n)~=p.y)
}

print(solution(3))
