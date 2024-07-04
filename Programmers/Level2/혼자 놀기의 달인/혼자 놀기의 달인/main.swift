//
//  main.swift
//  혼자 놀기의 달인
//
//  Created by 양승현 on 7/4/24.
//

import Foundation

/// 이 문제는 문해력이 있어야  더빨리 풀수있는 문제같다.
///
/// 2~100 카드는 각각의 number 유일하고 특정한 숫자 선정시 작거나 같은 카드들로 구성하고, 그걸 상자에 담아 임의대로
///   섞어가지구 그게!!!!
///   -> cards에 고스란히 담겨짐.
///
/// 문제에서 장황한 로직은 내용은 맨 아래에 의해 결국 매개변수로 그 임의 정렬된 카드 상자들과, 안에 담긴 카드 번호가 cards로 왔을때
/// 여러 group중 개수 큰 두 그룹 곱해서 반환해라.
/// ----
/// cards -> 특정 상자 뽑았을때 해당 상자 안 카드 숫자에 해당하는 상자를 탐색. 두번 탐색은 안됨.
/// 연결리스트느낌으로 구현하라는 의미다.
func solution(_ cards:[Int]) -> Int {
  let cards = cards.map { $0 - 1 }
  var groups: [Int] = []
  var visited = (0..<cards.count).map { _ in false }
  for i in cards.indices {
    var sCards: [Int] = []
    var idx = i
    while !visited[idx] {
      visited[idx] = true
      sCards.append(cards[idx])
      idx = cards[idx]
    }
    groups.append(sCards.count)
  }
  if groups.count == 1 { return 0 }
  let sorted = groups.sorted(by: >)
  return sorted[0] * sorted[1]
}
