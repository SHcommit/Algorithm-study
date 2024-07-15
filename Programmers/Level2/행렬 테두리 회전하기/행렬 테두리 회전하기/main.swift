//
//  main.swift
//  행렬 테두리 회전하기
//
//  Created by 양승현 on 7/15/24.
//

import Foundation

// 초기 설계는
// 예를들어 1 2 3 4
//        5     6
//        7 8 9 10
// 이걸 시계 방향 이동시 4번을 temp에 저장하고
//    1,2,3 한칸씩! -> 5, 7 한칸 위로 -> 8, 9, 10 한칸 왼쪽, 6만 한칸아래 + temp를 6자리에 이렇게 설계를 함.
//    근데 구현하다보니 나도모르게 포문을 한 개 줄이고자 x -> y -> x -> y이렇게 이동하지 않고 x를 연달아 y1, y2시점 동시에 먼저 이동시켜서
//    최소값이 일치하지 않았음.
func solution(_ rows:Int, _ columns:Int, _ queries:[[Int]]) -> [Int] {
  var matrix = (0..<columns).map { col in
    (1...rows).map { row in rows*col + row }
  }
  return queries.map { query in
    let x1 = query[0]-1, y1 = query[1]-1, x2 = query[2]-1, y2 = query[3]-1
    let temp = matrix[y1][x2]
    var minValue = temp
    for x in stride(from: x2-1, through: x1, by: -1) {
      minValue = min(minValue, matrix[y1][x])
      matrix[y1][x+1] = matrix[y1][x]
    }
    for y in y1+1...y2 {
      minValue = min(minValue, matrix[y][x1])
      matrix[y-1][x1] = matrix[y][x1]
    }
    
    for x in x1+1...x2 {
      minValue = min(minValue, matrix[y2][x])
      matrix[y2][x-1] = matrix[y2][x]
    }
    
    for y in stride(from: y2-1, through: y1+1, by: -1) {
      minValue = min(minValue, matrix[y][x2])
      matrix[y+1][x2] = matrix[y][x2]
    }
    matrix[y1+1][x2] = temp
    return minValue
  }
}
print(solution(100, 97,   [[1,1,100,97]]))
