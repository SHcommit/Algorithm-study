//
//  main.swift
//  [baekjoon]16509
//
//  Created by 양승현 on 2023/04/20.
//

// PS일지.
// 이 경우 문제를 잘 봐야하는데. 어디에 쫄병이 있는지 도무지 몰랐다. 근데 결국 내가 가야할 길에 왕이 있으면
// 왕을 뛰어서 갈 수가 없는 것. 이 경우만 봐준다면 맞는다.
// 근데 난 왜 이렇게 수작업으로 했을까;;...
import Foundation
typealias Point = (x:Int,y:Int)
typealias Element = (Point,c:Int)
let direction: [[Point]] = [
  [(1,0),(1,1),(1,1)],
  [(1,0),(1,-1),(1,-1)],
  [(-1,0),(-1,1),(-1,1)],
  [(-1,0),(-1,-1),(-1,-1)],
  [(0,-1),(-1,-1),(-1,-1)],
  [(0,1),(-1,1),(-1,1)],
  [(0,-1),(1,-1),(1,-1)],
  [(0,1),(1,1),(1,1)]
]
var visited = Array(repeating: Array(repeating: false, count: 9), count: 10)
let input = (0..<2).map{_ in return readLine()!.split{$0==" "}.map{Int(String($0))!}}
let s:Point = (input[0][1],input[0][0])
let e:Point = (input[1][1],input[1][0])
func isOutOfBounds(_ p:Point) ->Bool {
  return p.x<0 || p.y<0 || p.x>8 || p.y>9
}
func isCleanRoot(_ p:Point) -> Bool {
  return p.x == e.x && p.y == e.y
}
func bfs(completion: (Int)->Void) {
  var queue: [Element] = [(s,0)]
  var idx = 0
  visited[s.y][s.x] = true
  while idx < queue.count {
    let cx = queue[idx].0.x, cy=queue[idx].0.y
    let c = queue[idx].c
    if cx == e.x && cy == e.y { completion(c); return }
    _=direction.map{
      var tempX = cx, tempY = cy
      for i in $0.enumerated() {
        tempX+=i.element.x; tempY+=i.element.y
        if isOutOfBounds((tempX,tempY)) { break }
        if i.offset < 2 && isCleanRoot((tempX,tempY)) { break }
        if !visited[tempY][tempX] && i.offset == 2{
          visited[tempY][tempX] = true
          queue.append(((tempX,tempY),c+1))
          
        }
      }
      
    }
    idx += 1
  }
  completion(-1)
}
bfs{print($0)}
