//
//  main.swift
//  StrollingInThePark
//
//  Created by 양승현 on 6/3/24.
//

import Foundation

/// 이동하기 전에, 체크.
/// - 주어진 방향으로 이동할 때 공원 벗어나는가?
/// - 주어진 방향으로 이동 중 장애물을 만나는가?
///
/// 하나라도 해당된다면, 이동하는 명령 무시 후 다음 명령을 수행한다.
///


/// bfs로 풀어도 되는데 난 그냥 구현을 해봤다.
typealias Route = (direct: String, distance: Int)
typealias Point = (x: Int, y: Int)

func solution(_ inputPark:[String], _ inputRoutes:[String]) -> [Int] {
  let directPoint: [Point] = [(-1,0),(1,0),(0,-1),(0,1)]
  let directIndex: [String: Int] = ["W":0, "E":1, "N":2,"S":3]
  let routes: [Route] = inputRoutes.map {
    let splited = $0.split { $0==" " }
    return (String(splited[0]), Int(splited[1])!)
  }
  var obstacles: [Point] = []
  var curPoint: Point = (0,0)
  let parkSize: Point = (inputPark[0].map { $0 }.count,inputPark.count)
  
  inputPark.enumerated().forEach { y, trail in
    let splited = trail.map { String($0) }.enumerated()
    for (x, ground) in splited where ground != "O" {
      if ground == "X" {
        obstacles.append((x,y))
      } else {
        curPoint = (x,y)
      }
    }
  }
  
  routes.forEach { route in
    let curDirectPoint = directPoint[directIndex[route.direct]!]
    let nextDirect: Point = (curPoint.x + curDirectPoint.x * route.distance, curPoint.y + curDirectPoint.y * route.distance)
    if (0..<parkSize.x).contains(nextDirect.x) && (0..<parkSize.y).contains(nextDirect.y) {
      /// 만약 장애물이 중간에 있었다면?
      var hasObstacle = false
      for obstacle in obstacles {
        if curDirectPoint.y == 0, obstacle.y == nextDirect.y {
          if curPoint.x < nextDirect.x {
            if (curPoint.x...nextDirect.x).contains(obstacle.x) {
              hasObstacle = true
              break
            }
          } else {
            if (nextDirect.x...curPoint.x).contains(obstacle.x) {
              hasObstacle = true
              break
            }
          }
        } else if curDirectPoint.x == 0, obstacle.x == nextDirect.x {
          if curPoint.y < nextDirect.y {
            if (curPoint.y...nextDirect.y).contains(obstacle.y) {
              hasObstacle = true
              break
            }
          } else {
            if (nextDirect.y...curPoint.y).contains(obstacle.y) {
              hasObstacle = true
              break
            }
          }
        }
      }
      
      if !hasObstacle {
        curPoint = nextDirect
      }
    }
  }
  
  /// 로봇 강아지가 명령 후 놓인 위치를 세로방향 좌표, 가로방향 좌표 순으로 담아서 반환해라.
  return [curPoint.y, curPoint.x]
}

print(solution(["OOO","OSO","OOO"], ["W 1"]))
