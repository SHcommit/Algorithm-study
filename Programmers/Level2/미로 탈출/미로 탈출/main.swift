//
//  main.swift
//  미로 탈출
//
//  Created by 양승현 on 6/13/24.
//

import Foundation

typealias Point = (x: Int, y: Int)
typealias Element = (p: Point, sec: Int?)
let Direction = [(-1,0), (1,0), (0,1), (0,-1)]

var width = 0
var height = 0
var maps: [[String]] = []

func solution(_ input:[String]) -> Int {
  var sPoint: Point = (0,0), ePoint = (0,0), lPoint = (0,0)
  maps = input.enumerated().map { (y, line) in
    return line.enumerated().map { (x, room) in
      if room == "X" { return String(room) }
      if room == "S" {
        sPoint = (x,y)
      } else if room == "E" {
        ePoint = (x,y)
      } else if room == "L" {
        lPoint = (x,y)
      }
      return "O"
    }
  }
  height = maps.count
  width = maps[0].count
  guard let secOfDetectedL = bfs((sPoint, 0), endPoint: lPoint) else { return -1 }
  guard let secOfDetectedE = bfs((lPoint, secOfDetectedL), endPoint: ePoint) else { return -1 }
  return secOfDetectedE
}

@inline(__always)
func isOutOfBounds(_ p: Point) -> Bool {
  return !(0..<width).contains(p.x) || !(0..<height).contains(p.y)
}

func bfs(_ start: Element, endPoint: Point) -> Int? {
  var visited = Array(repeating: Array(repeating: false, count: width), count: height)
  var queue: [Element] = [start]
  var queueIdx = 0
  visited[start.p.y][start.p.x] = true
  while queue.count > queueIdx {
    let current = queue[queueIdx]
    let cp = current.p
    let currentSec = current.sec
    for (dx, dy) in Direction {
      let n: Point = (cp.x + dx, cp.y + dy)
      if isOutOfBounds(n) { continue }
      if maps[n.y][n.x] == "X" { continue }
      if visited[n.y][n.x] { continue }
      if n.x == endPoint.x && n.y == endPoint.y { return currentSec! + 1 }
      visited[n.y][n.x] = true
      queue.append((n, currentSec! + 1))
    }
    queueIdx += 1
  }
  return nil
}
