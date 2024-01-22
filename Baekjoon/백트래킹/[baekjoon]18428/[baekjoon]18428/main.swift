//
//  main.swift
//  [baekjoon]18428
//
//  Created by 양승현 on 1/22/24.
//

import Foundation

typealias Point = (x: Int, y:Int)
let n = Int(readLine()!)!
var teachers: [Point] = []
var board:[[String]] = (0..<n).map{y in readLine()!.split{$0==" "}.enumerated().map{
  let s = String($1)
  if s == "S" { teachers.append((x: $0, y:y)) }
  return s
}}
var isUsed = (0..<n*n).map{_ in false}
func combi(of k: Int, seq: [Int]) {
  if seq.count == 3 {
    for i in 0..<3 {
      let y = seq[i]/n, x = seq[i]%n
      guard board[y][x] == "X" else {
        return
      }
    }
    check(from: seq)
    return
  }
  for i in k..<n*n {
    combi(of: i+1, seq: seq+[i])
  }
}
func check(from obstacles: [Int]) {
  for i in 0..<3 {
    let y = obstacles[i]/n, x = obstacles[i]%n
    board[y][x] = "O"
  }
  defer {
    for i in 0..<3 {
      let y = obstacles[i]/n, x = obstacles[i]%n
      board[y][x] = "X"
    }
  }
  for teacher in teachers {
    var u = false, d = false, l = false, r = false
    for i in 0..<n {
      var temp = 0
      temp = teacher.y+i
      if !d && temp < n {
        if board[temp][teacher.x] == "T" {
          return
        }
        if board[temp][teacher.x] == "O" {
          d.toggle()
        }
      }
      temp = teacher.y-i
      if !u && temp > -1 {
        if board[temp][teacher.x] == "T" {
          return
        }
        if board[temp][teacher.x] == "O" {
          u.toggle()
        }
      }
      temp = teacher.x-i
      if !l && temp > -1 {
        if board[teacher.y][temp] == "T" {
          return
        }
        if board[teacher.y][temp] == "O" {
          l.toggle()
        }
      }
      temp = teacher.x+i
      if !r && temp < n {
        if board[teacher.y][temp] == "T" {
          return
        }
        if board[teacher.y][temp] == "O" {
          r.toggle()
        }
      }
    }
  }
  print("YES")
  exit(0)
}

combi(of: 0, seq: [])
print("NO")
