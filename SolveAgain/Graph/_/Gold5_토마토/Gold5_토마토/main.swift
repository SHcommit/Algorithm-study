//
//  main.swift
//  Gold5_토마토
//
//  Created by 양승현 on 10/31/24.
//

import Foundation
typealias Point = (x:Int, y:Int)
let Direction: [Point] = [(-1,0),(0,-1),(1,0),(0,1)]
let wh = readLine()!.split{$0==" "}.compactMap { Int($0) }
let width = wh[0],height = wh[1]
var farm = (0..<height).map { _ in readLine()!.split{$0==" "}.compactMap { Int($0) } }
var queue: [Point] = [], idx = 0, res = 0
for y in 0..<height {
  for x in 0..<width {
    if farm[y][x] == 1 { queue.append((x,y)) }
  }
}
while idx < queue.count {
  let cur = queue[idx]
  idx += 1
  for d in Direction {
    let next: Point = ( cur.x+d.x, cur.y+d.y )
    guard (0..<height)~=next.y && (0..<width)~=next.x else { continue }
    let nextInfo = farm[next.y][next.x]
    if nextInfo == -1 || nextInfo != 0 { continue }
    farm[next.y][next.x] = farm[cur.y][cur.x] + 1
    queue.append(next)
  }
}
if !farm.contains(where: { line in line.contains(where: {$0==0})}) {
  farm.forEach { res = max($0.max()!, res) }
}
print(res-1)
