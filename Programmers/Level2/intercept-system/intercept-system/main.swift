//
//  main.swift
//  intercept-system
//
//  Created by 양승현 on 5/23/24.
//

import Foundation

/// 내 계획.. 처음 s를 소팅하고 s에서 가장 긴 E를 찾아서, count + 1증가시키며 e를 s로 적용하고 또 그 s에서 가장 긴 e들ㄹ 찾으며 개선하고있엇따.
/// 이 계획은 맞았으나 "e"를 잘 활용하지 못하.ㅁ
///
/// 예를들어 소팅할때 sorted { $0[0] < $1[0]} 으로 하게되면 문제가 뭘까?
/// 문제는 이 경우다
///
//    |---|--|
///   |-------------|
///   1   2   3   4
///
/// 여기서 처음 탐색할떄 e가 4가 된다면? 다음 폭격 위치는 4와 같거나 4보다 커야한다.
/// 근데 그럼 2,3 은 제외된다. 그러나 사실은 3에서 한번 더 그어야한다. 그래서 e를 탐색할때 e가 가장 작은것 순으로 소팅되야한다.
///
/// 그래서  targets 포문돌때 e가 4가 아니라 3이 되도록! 가장 작은 e를 기준으로 e를 다음 s로 시작하고.. 의 반복을 거쳐야한다.

func solution(_ inputTargets:[[Int]]) -> Int {
  let targets = inputTargets
    .sorted { $0[1] < $1[1] }
  var intercepts = 0
  var interceptX = 0
  for target in targets {
    if target[0] < interceptX { continue }
    intercepts += 1;  interceptX = target[1];
  }
  return intercepts
}
