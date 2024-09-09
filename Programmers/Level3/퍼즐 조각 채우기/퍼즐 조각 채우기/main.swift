//
//  main.swift
//  퍼즐 조각 채우기
//
//  Created by 양승현 on 9/6/24.
//

import Foundation

/// 어후;;
/// 모든 좌표는 일단 최소 좌표를 기준으로, 정렬해서! 비교하면 된다.
///
/// 게임보드의 빈칸이나 모든 좌표는 내가 정한 정렬 순서로 정렬된 좌표끼리, 이제 비교가 가능해짐.
///
/// matrix에서 회전할 때는 x,y -> y,-x를 통해서 회전할 수있음
/// 배열의 경우 temp[x][n-1-y] = arr[y][x]
///
/// 문제 접근 방식:
///  일단 게임보드에서 빈 좌표들 찾아! 그게 하나의 블럭을 형성함.
///  놓을수있는 블럭 좌표들도 찾아.
///
///  이때이제 게임보드에서 빈 좌표들 개수가 블럭 개수와 같은지! 이래야만 블럭을 놓았을때 추가적으로 빈 공간이 안생기는거 보장!
///
///  x,y -> y,-x 이렇게 90도 회전했을때의 좌표들을 내가 원한느 형태로 정렬해서, 기존에 정렬된 빈 공간에 놓을수 있는지를 비교함.
struct Point: Hashable {
  var x: Int
  var y: Int
  init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
  }
}

typealias BlockPoints = [Point]
let directions: [Point] = [(0,1),(0,-1),(-1,0),(1,0)].map { .init($0.0, $0.1) }

func solution(_ game_board:[[Int]], _ table:[[Int]]) -> Int {
  var gameBoard = game_board
  var table = table
  let n = table.count
  var emptyBlocks: [BlockPoints] = []
  
  for y in 0..<n {
    for x in 0..<n where gameBoard[y][x] == 0 {
      let blockPoints = bfs(Point(x, y), in: gameBoard, searchCondition: { $0 == 0 })
      emptyBlocks.append(normalize(blockPoints))
      blockPoints.forEach { gameBoard[$0.y][$0.x] = 1 }
    }
  }
  
  var pieceBlocks: [BlockPoints] = []
  
  for y in 0..<n {
    for x in 0..<n where table[y][x] == 1 {
      let blockPoints = bfs(Point(x, y), in: table, searchCondition: { $0 == 1 })
      pieceBlocks.append(normalize(blockPoints))
      blockPoints.forEach { table[$0.y][$0.x] = 0 }
    }
  }
  
  var filledCount = 0
  
  for piece in pieceBlocks {
    for rotation in 0..<4 {
      let rotatedPiece = rotate(piece, rotation)
      if let index = emptyBlocks.firstIndex(where: { $0 == rotatedPiece }) {
        filledCount += rotatedPiece.count
        emptyBlocks.remove(at: index)
        break
      }
    }
  }
  
  return filledCount
}

func rotate(_ points: BlockPoints, _ times: Int) -> BlockPoints {
  var result = points
  for _ in 0..<times {
    let maxX = result.max(by: { $0.x < $1.x })!.x
    result = result.map { Point(maxX - $0.y, $0.x) }
  }
  return normalize(result)
}


func normalize(_ points: BlockPoints) -> BlockPoints {
  let minX = points.min(by: { $0.x < $1.x })!.x
  let minY = points.min(by: { $0.y < $1.y })!.y
  return points.map { Point($0.x - minX, $0.y - minY) }.sorted(by: { $0.x == $1.x ? $0.y < $1.y : $0.x < $1.x })
}

func bfs(_ start: Point, in board: [[Int]], searchCondition: (Int) -> Bool) -> BlockPoints {
  let n = board.count
  var visited = Array(repeating: Array(repeating: false, count: n), count: n)
  visited[start.y][start.x] = true
  var queue: [Point] = [start]
  var index = 0
  while index < queue.count {
    let current = queue[index]
    index += 1
    for direction in directions {
      let next = Point(current.x + direction.x, current.y + direction.y)
      if isOutOfBounds(next, n: n) || visited[next.y][next.x] || !searchCondition(board[next.y][next.x]) { continue }
      visited[next.y][next.x] = true
      queue.append(next)
    }
  }
  return queue
}
func isOutOfBounds(_ p: Point, n: Int) -> Bool { !((0..<n)~=p.x && (0..<n)~=p.y) }
