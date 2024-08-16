//
//  main.swift
//  카펫
//
//  Created by 양승현 on 8/16/24.
//

import Foundation


/// 문제 접근:  규칙을 좀 찾아보려고했는데 규칙을 찾을 수  없었다.
/// 그렇지만 브라운에서 양끝 엣지 격자 개수 제거하고, 남은 브라운 격자 개수들을 가: 세 비율로 완탐으로 나눴을 때(가로가 세로보다 크거나 같음을 기준으로) 가*세 크기가
/// 옐로와 같으면 정답!으로 설계해봤다.
func solution(_ brown:Int, _ yellow:Int) -> [Int] {
  let withoutEdgeBrownCnt = brown-4
  for width in (withoutEdgeBrownCnt/2..<withoutEdgeBrownCnt) {
    let height = withoutEdgeBrownCnt-width
    guard height % 2 == 0 || width % 2 == 0 else { continue }
    let halfWidth = width/2
    let halfHeight = height/2
    if halfWidth*halfHeight == yellow {
      return [halfWidth+2, halfHeight+2]
    }
  }
  fatalError()
}
