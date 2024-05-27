//
//  main.swift
//  race_of_running
//
//  Created by 양승현 on 5/27/24.
//

import Foundation

/// 자기 바로 앞 선수 추월할 때 추월한 선수의 이름을 부른다.
/// 1 , 2, 3  = 무무, 소에, 포에 선수인데.
/// 소에를 부르면 2등이 1등을 추월한거임 그럼
/// 소에 ,무무, 포에가 되는거지.
///
/// 선수의 이름을 부르면 앞 사람과 바뀐다.

/// 경주 끝났을떄 선수 이름을 등수로 순차적으로 반환해라.
///
/// - Parameters inputPlayers: 선수 1등~ 현재 등수가 순서대로 담김
/// - Parameters callings: 해설진이 부른 이름을 담은 문자열 배열이 순차적으로 주어짐.
func solution(_ inputPlayers:[String], _ callings:[String]) -> [String] {
  var players: [String: Int] = [:]
  var ratings: [Int: String] = [:]
  for (i, x) in inputPlayers.enumerated() {
    players[x] = i
    ratings[i] = x
  }
  callings.forEach {
    let rating = players[$0]!
    let aheadPlayer = ratings[rating-1]!
    players[$0] = rating - 1
    players[aheadPlayer] = rating
    ratings[rating] = aheadPlayer
    ratings[rating - 1] = $0
  }
  return players.sorted { $0.value < $1.value }.map { $0.key }
}

print(solution(["mumu", "soe", "poe", "kai", "mine"], ["kai", "kai", "mine", "mine"]))
