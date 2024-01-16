//
//  main.swift
//  [baekjoon]1941
//
//  Created by 양승현 on 1/16/24.
//

import Foundation
/*
  느낀점:
 확실히 이전에 dfs로 맨 처음에 조합을 구해나가는 것보다 한번에 조합을 미리 구한후에 구현하는게 더 빠르다는 체감이 확 들었다.
 근데 다른사람들 푼거 무엇.. 다 잘푸네ㅠㅅㅠ..
 */
let n=5
let board = (0..<n).map{_ in return readLine()!.map{ String($0)}}
var ans = 0
typealias Point = (x: Int, y: Int)
let direction: [Point] = [(-1,0),(0,1),(1,0),(0,-1)]

func isMoreThanFour(_ selected: [Int]) -> Bool {
  var sCnt = 0
  for i in 0..<7 {
    let x = selected[i] % n
    let y = selected[i] / n
    if board[y][x] == "S" { sCnt += 1 }
    if sCnt == 4 { return true }
  }
  return false
}

func bfs(_ selected: [Int]) -> Bool {
  var visited = (0..<n).map{_ in (0..<n).map{_ in false}}
  var hasSelected = (0..<n).map{_ in (0..<n).map{_ in false}}
  var queue: [Point] = []
  var idx = 0
  var count = 1
  var isFirstSave = false
  for s in selected {
    let y = s/n
    let x = s%n
    hasSelected[y][x] = true
    if !isFirstSave {
      isFirstSave = true
      visited[y][x] = true
      queue.append((x,y))
    }
  }
  while queue.count > idx {
    let c = queue[idx]
    for d in direction{
      let (nx, ny) = (c.x+d.x, c.y+d.y)
      if !(0..<n).contains(nx) || !(0..<n).contains(ny) { continue }
      if hasSelected[ny][nx] && !visited[ny][nx] {
        count += 1
        if count == 7 { return true }
        visited[ny][nx] = true
        queue.append((nx,ny))
      }
    }
    idx += 1
  }
  return false
}

func combi(arr: [Int], n: Int) -> [[Int]] {
  var combiArr = [[Int]]()
  func dfs(index: Int, now: [Int]) {
    if now.count == n {
      combiArr.append(now)
      return
    }
    for i in index..<arr.count {
      dfs(index: i + 1, now: now + [arr[i]])
    }
  }
  dfs(index: 0, now: [])
  return combiArr
}

combi(arr: Array(stride(from: 0, through: 24, by: 1)), n: 7).forEach {
  if isMoreThanFour($0) {
    if bfs($0) { ans += 1 }
  }
}
print(ans)
