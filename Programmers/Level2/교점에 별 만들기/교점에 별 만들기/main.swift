//
//  main.swift
//  교점에 별 만들기
//
//  Created by 양승현 on 7/11/24.
//

import Foundation

/// 최소는 Int.min, 최대는 Int.max를 해야 정확한 결과가 나옴.
/// x,y 점들을 콘솔창의 좌표계로 표시하기 위해서는 maxY - y . minX - x 이렇게 표시.
/// 좋네. 좋아. 나는 x가 0보다 작을때, 클때 이렇게 구분지어서 abs사용했는데 훨 간단함
typealias Point = (x: Int, y: Int)
func solution(_ line:[[Int]]) -> [String] {
  let n = line.count
  var intersectionPoints: [Point] = []
  var minX=Int.max, maxX=Int.min, minY=Int.max, maxY=Int.min
  for first in 0..<n-1 {
    for sec in first+1..<n {
      let fL = line[first], sL = line[sec]
      let denominator = fL[0]*sL[1] - fL[1]*sL[0]
      if denominator == 0 { continue }
      let xNumerator = fL[1]*sL[2] - fL[2]*sL[1], yNumerator = fL[2]*sL[0] - fL[0]*sL[2]
      if abs(xNumerator) % abs(denominator) != 0 { continue }
      if abs(yNumerator) % abs(denominator) != 0 { continue }
      let x = xNumerator/denominator, y = yNumerator/denominator
      intersectionPoints.append((x, y))
      minX = min(x, minX); maxX = max(x, maxX)
      minY = min(y, minY); maxY = max(y, maxY)
    }
  }
  
  let width = maxX - minX + 1
  let height = maxY - minY + 1
  var res = Array(repeating: Array(repeating: ".", count: width), count: height)
  intersectionPoints.forEach { x, y in res[maxY-y][x-minX] = "*" }
  return res.map { $0.joined() }
}

print(solution([[0, 1, -1], [1, 0, -1], [1, 0, 1]]))
