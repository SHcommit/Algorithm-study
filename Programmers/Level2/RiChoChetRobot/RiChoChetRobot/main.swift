//
//  main.swift
//  RiChoChetRobot
//
//  Created by 양승현 on 6/10/24.
//

import Foundation

typealias Point = (x: Int, y: Int)

let Direction: [Point] = [(-1,0),(1,0),(0,1),(0,-1)]
var board: [[String]] = []
var start: Point = (-1, -1), end: Point = (-1,-1)
var width = 0, height = 0

func solution(_ input:[String]) -> Int {
  board = input.enumerated().map { y, line in
    return line.enumerated().map { x, char in
      let str = String(char)
      if start.x == -1, str == "R" {
        start = (x,y)
        return "."
      }
      if end.x == -1, str == "G" {
        end = (x,y)
        return "."
      }
      return str
    }
  }
  
  width = board[0].count
  height = board.count
  
  return bfs()
}


func bfs() -> Int {
  var hasVisited = Array(repeating: Array(repeating: Int.max, count: board[0].count), count: board.count)
  hasVisited[start.y][start.x] = 0
  var queueIdx = 0
  var queue: [Point] = [start]
  while queue.count > queueIdx {
    let (cx, cy) = queue[queueIdx]
    if cx == end.x && cy == end.y {
      return hasVisited[cy][cx]
    }
    for d in Direction {
      let (nx,ny) = detectNext((cx,cy), from: d)
      if !(0..<width).contains(nx) || !(0..<height).contains(ny) { continue }
      if hasVisited[ny][nx] < hasVisited[cy][cx] + 1 { continue }
      hasVisited[ny][nx] = hasVisited[cy][cx] + 1
      queue.append((nx, ny))
    }
    queueIdx += 1
  }
  return -1
}

func detectNext(_ currentPoint: Point, from directPoint: Point) -> Point {
  var nextPoint: Point = currentPoint
  while true {
    let tempNextPoint: Point = (nextPoint.x + directPoint.x, nextPoint.y + directPoint.y)
    if (0..<width).contains(tempNextPoint.x) && (0..<height).contains(tempNextPoint.y) {
      if board[tempNextPoint.y][tempNextPoint.x] == "." {
        nextPoint = tempNextPoint
        continue
      } else {
        break
      }
    } else {
      break
    }
  }
  return nextPoint
}


print(solution(["...D..R", ".D.G...", "....D.D", "D....D.", "..D...."] ))
