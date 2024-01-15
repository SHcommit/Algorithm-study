//
//  main.swift
//  [baekjoon]9663
//
//  Created by 양승현 on 1/15/24.
//

import Foundation

/*
  y+1 == n을 재귀 첫 시작할 때의 함수에서 조건비교하고 반환하는 로직을 짰는데 그것보다
  반복문에서 y+1 == n일때를 측정한 후에 함수 한번 호출하지 않고 바로 다음루프돌리는게 더 빠르다.
 */

typealias Point = (x: Int, y: Int)
let n = Int(readLine()!)!
var res = 0
var board = (0..<n).map{_ in return (0..<n).map{_ in return false}}
func track(of y: Int) {
  for x in 0..<n {
    if hasCrossed((x,y)) { continue }
    if y+1 == n {
      res += 1
      continue
    }
    board[y][x] = true
    track(of: y + 1)
    board[y][x] = false
  }
}
func hasCrossed(_ p: Point) -> Bool {
  if p.y == 0 { return false }
  for i in 1...p.y {
    let dy = p.y - i
    if board[dy][p.x] { return true }
  }
  for i in 1...p.y {
    let dy = p.y - i
    let dx1 = p.x - i
    let dx2 = p.x + i
    if (dx1 >= 0 && board[dy][dx1]) || (dx2<=n-1 && board[dy][dx2]) {
      return true
    }
  }
  return false
}
track(of: 0)
print(res)
