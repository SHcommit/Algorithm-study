//
//  main.swift
//  [baekjoon]3187-retry
//
//  Created by 양승현 on 1/26/24.
//

import Foundation

typealias Point = (x:Int, y:Int)
let hw = readLine()!.split{$0==" "}.map{Int($0)!}, H = hw[0], W = hw[1]
let direction: [Point] = [(-1,0),(1,0),(0,1),(0,-1)]
var animals: [Point] = []
var sheep = 0, wolf = 0, tempSheep = 0, tempWolf = 0
var board: [[String]] = (0..<H).map{ y in
  {
    for (x,v) in $0.enumerated() where v=="v"||v=="k" { animals.append((x:x,y:y)) }
    return $0
  }(readLine()!.map{String($0)})
}
func dfs(of p: Point) {
  if !(0..<H).contains(p.y) || !(0..<W).contains(p.x) || board[p.y][p.x] == "#" { return }
  if board[p.y][p.x] == "k" { tempSheep += 1 }
  if board[p.y][p.x] == "v" { tempWolf += 1 }
  board[p.y][p.x] = "#"
  direction.forEach { dfs(of: (p.x+$0.x,p.y+$0.y)) }
}
animals.forEach {
  tempSheep = 0
  tempWolf = 0
  dfs(of: $0)
  if tempWolf - tempSheep < 0 { sheep += tempSheep }
  else { wolf += tempWolf }
}
print("\(sheep) \(wolf)")
