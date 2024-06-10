//
//  main.swift
//  ClearTheDesktop
//
//  Created by 양승현 on 6/10/24.
//

import Foundation

/// 바탕화면 아무 위치에나 작성한 코드들을 저장해 둔다.
/// 지저분해져가지구 바탕화면을 전부 삭제하려고 한다.
///
/// 바탕화면은 각 칸이 정사각형인 격자판이다.
///
/// 빈칸 " . ", 파일이 있는 칸 " # "
///
/// 드래그 하면 파일 선택
/// 선택된 파일을 제거 가능.
///
/// 최소한의 이동거리를 갖는 한번의 드래그로, 모든 파일을 선택해서 한번에 지우려함.
///
/// 드래그 파일 선택 방법
/// - 바탕화면의 격자 점 
/// -     S(lux, luy)(시작점)를 마우스 왼쪽 버튼으로 클릭한 상태로
/// -      E(rdx, rdy)(끝점)로 이동한 뒤 마우스 왼쪽 버튼 떼는 행동.
/// S -> E 로 드래그 한다.
///
/// 드래그한 거리는 | e.rdx - s.lux | + | e.rdy - s.luy |
func solution(_ wallpaper:[String]) -> [Int] {
  var minX = Int.max, minY = minX, maxX = 0, maxY = 0
  _=wallpaper.enumerated().map { y, items in
    items.enumerated().map { x, item in
      if item == "#" {
        minX = min(x, minX)
        minY = min(y, minY)
        maxX = max(x, maxX)
        maxY = max(y, maxY)
      }
    }
  }
  return [minY, minX, maxY+1, maxX+1]
}

print(solution([".#...", "..#..", "...#."]))
