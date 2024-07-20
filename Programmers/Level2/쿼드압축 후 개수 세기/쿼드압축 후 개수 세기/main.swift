//
//  main.swift
//  쿼드압축 후 개수 세기
//
//  Created by 양승현 on 7/20/24.
//

import Foundation

/// 새로 알게된 사실
/// 프로그래머스에선
///
/// typealias Point = (x: Int, y: Int)
/// let t: Point = (1,0)
/// let seq = [(1,0),(2,0), t]
/// func recur(p: Point) { }
///
/// recur(p: seq) ///이걸 추론 못한다.
///
/// - 타입을 명확하게 지정하자!!


/// s.y + length/2 == center.x 이게 네이밍이 좋다.
///
/// [[0,0][0,0]] 이 경우는 0
/// [[1,1,1],[1,1,1],[1,1,1]] 이 경우는 1.
/// 이 조건들을 대응해야한다.
///
/// 난 재귀로 풀었는데 dfs로도 접근한 풀이가있는데 깔끔하네,,.
typealias Point = (x: Int, y: Int)
typealias Res = (zeroCnt: Int, oneCnt: Int)
var arr: [[Int]] = []

func solution(_ input:[[Int]]) -> [Int] {
  arr = input
  let flatten = input.flatMap { $0 }
  let zeroCnt = flatten.filter { $0==0 }.count
  let oneCnt = flatten.filter { $0==1 }.count
  if input.count == 2 {
    return [zeroCnt == 4 ? 1 : zeroCnt, oneCnt == 4 ? 1: oneCnt]
  } else if zeroCnt == input.count*input.count {
    return [1,0]
  } else if oneCnt == input.count*input.count {
    return [0,1]
  }
  let res = recur(startPoint: (0,0),length: input.count)
  return [res.zeroCnt, res.oneCnt]
}

func recur(startPoint s: Point, length: Int) -> Res {
  if length == 1 {
    if arr[s.y][s.x] == 1 {
      return (0,1)
    }
    return (1,0)
  }
  let halfLengthOfHeight = length/2 + s.y
  let halfLengthOfWidth = length/2 + s.x
  /// 0은 -로 감소
  /// 1은 +로 추가
  /// [왼위, 오위, 좌아래, 우아래]
  var quarters = [0,0,0,0]
  for y in s.y..<s.y+length {
    for x in s.x..<s.x+length {
      let element = arr[y][x]
      var quarterIdx = 0
      if y < halfLengthOfHeight {
        /// 왼위
        if x < halfLengthOfWidth {
          quarterIdx = 0
        } else {
          //// 오위
          quarterIdx = 1
        }
      } else {
        /// 좌아래
        if x < halfLengthOfWidth {
          quarterIdx = 2
        } else {
          /// 우아래
          quarterIdx = 3
        }
      }
      quarters[quarterIdx] += element > 0 ? 1 : -1
    }
  }
  
  var res: [Res] = []
  let seq: [Point] = [s, (halfLengthOfWidth, s.y),
             (s.x, halfLengthOfHeight), (halfLengthOfWidth,halfLengthOfHeight)]
  let maxOneCnt = length*length/4
  let maxZeroCnt = -maxOneCnt
  
  /// 여기서 난 재귀 조건을 단순히 0으로 생각함. 사이즈가 4칸일 때 +1 +1 0 0 이렇게. 근데 그게 아니라 아예 4 or -4가 되야함.
  for (i, point) in seq.enumerated() {
    if quarters[i] == maxOneCnt {
      res.append((0,1))
    } else if quarters[i] == maxZeroCnt {
      res.append((1,0))
    } else {
      res.append(recur(startPoint: point, length: length/2))
    }
  }
  return res.reduce((0,0)) {
    ($0.zeroCnt + $1.zeroCnt, $0.oneCnt+$1.oneCnt)
  }
}

print(solution([[0,0],[0,0]]))
