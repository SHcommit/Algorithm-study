//
//  main.swift
//  거리두기 확인하기
//
//  Created by 양승현 on 7/14/24.
//

import Foundation

/// 우왕.. 풀었다.
/// 좀.. 배열이 작아서 그냥 완전 탐색 느낌으로다가 해도 시간복잡도가 크게 발생 안될거같아서 이렇게 풀음.
///
/// 1. 기준 P를 찾고 P를 기점으로 좌, 우, 하, 상 탐색. 이때 partition이 있다면 partitionD에 표시(L R Down Up ) 순서로 표시.
///   이때 P가 존재하면 맨해튼 거리가 1이어서 해당 방은 거리 안지킴.
///
/// 2. 대각선을 찾는데, 이떄 기준은 L U, U R, R D, D L 이렇게 각각에 대해 파티션이 존재할 경우에 스킵.
///   O X
///   X O 이런 형식은 대각선에 앉아도 노상관.
///     파티션이 하나만 있을 땐 해당 대각선이 사람인지만 판별후 있으면 해당 방 거리 안지킴.
/// 3. 파티션이 상 하 좌 우 각각에 대해 없을 경우에 한해 상 하 좌 우 ( 기준 P에서 2칸 ) 떨어진게 P라면 해당 방은 거리 안지킴.
///
/// 순회 다 했을때 거리 잘 지키면 1 반환!'
///
/// 아쉬운점은 뭔가 함수를 사용해서 중복 코드를 줄일 수 있지 않았을까 하는건데.. 시간 내에 최선을 다해 풀고자하니 좀 함수 사용이 까다로웠음.
let direction: [Point] = [(-1,0),(1,0),(0,1),(0,-1)]
typealias Point = (x: Int, y: Int)
func solution(_ places:[[String]]) -> [Int] {
  places.map { place in
    let room = place.map { d in d.map{ String($0) }}
    for y in 0..<5 {
      for x in 0..<5 {
        /// lrdu
        var partitionD = [false, false, false, false]
        if room[y][x] != "P" { continue }
        
        for (i, d) in direction.enumerated() {
          let n: Point = (d.x + x, d.y + y)
          if isOutOfRoom(n) {
            continue
          }
          let nState = room[n.y][n.x]
          if nState == "X" {
            partitionD[i] = true
          } else if nState == "P" {
            return 0
          }
        }
        
        /// 대각선
        for (d1, d2, d) in [(0,2, (-1,1)), (2,1,(1,1)),(1,3,(1,-1)),(3,0,(-1,-1))] {
          if !partitionD[d1] || !partitionD[d2] {
            let n: Point = (d.0+x,d.1+y)
            if !isOutOfRoom(n) {
              if room[n.y][n.x] == "P" { return 0 }
            }
          }
        }
        
        for (i,d) in direction.enumerated() {
          if partitionD[i] { continue }
          let n: Point = (d.x*2+x,d.y*2+y)
          if isOutOfRoom(n) { continue }
          let nState = room[n.y][n.x]
          if nState == "P" { return 0 }
        }
      }
    }
    return 1
  }
}
func isOutOfRoom(_ p: Point) -> Bool { !((0..<5)~=p.x) || !((0..<5)~=p.y) }
