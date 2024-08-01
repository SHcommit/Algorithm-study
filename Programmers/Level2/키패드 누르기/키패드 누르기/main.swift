//
//  main.swift
//  키패드 누르기
//
//  Created by 양승현 on 8/2/24.
//

import Foundation

/// 우욍 풀렸다...
/// 뭔가 상하좌우라는 말이 나와서 bfs로 접근하려다가 " 어디까지"라는 조건을 정하는것보다..
/// 맵이 3*4크기로 작아서 이진 트리처럼 상, 하위 부모의 idx를 접근하는 방식처럼 접근 해보고 싶었따.
/// -> 열은 / 3 , 행은 % 3 으로 나누며 똑 떨어진다.
/// 약간의 주의할 점은 키패드 숫자들은 맨 왼, 좌측부터 1이아닌 0부터 셌다. 그리고 이렇게 되면 원래 제공받은 numbers에서 원래 0인 경우는 10으로 바꾸어야 한다.
///
/// 이번엔 좀 더 설계를 한 후에 풀었는데 한 40분 걸린거같아서 기분이 좋음.
/// 특정 반환 조건마다, 현재 손 위치 갱신하는것도 포인트였다. (맨 마지막 하나 안썼다가 다시 코드 체크하면서 파악함)

typealias Point = (x: Int, y: Int)

func coordinator(_ n: Int) -> Point {
  (n%3, n/3)
}
func solution(_ _numbers:[Int], _ hand:String) -> String {
  let numbers = _numbers.map { $0 == 0 ? 10 : $0-1 }
  var curLP: Point = (0,3), curRP: Point = (2,3)
  return numbers.map {
    let number = $0, p = coordinator(number)
    if p.x == 0 {
      curLP = p
      return "L"
    } else if p.x == 2 {
      curRP = p
      return "R"
    }
    let distFromCurLToP = abs(p.x-curLP.x) + abs(p.y-curLP.y)
    let distFromCurRToP = abs(p.x-curRP.x) + abs(p.y-curRP.y)
    guard distFromCurLToP == distFromCurRToP else {
      if distFromCurLToP < distFromCurRToP {
        curLP = p
        return "L"
      }
      curRP = p
      return "R"
    }
    if hand == "right" {
      curRP = p
      return "R"
    }
    curLP = p
    return "L"
  }.joined()
}

print(solution([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
               
               
               
               
               
               
               
               
               
               
               
               
               
               , "right"))
