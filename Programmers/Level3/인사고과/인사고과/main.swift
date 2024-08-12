//
//  main.swift
//  인사고과
//
//  Created by 양승현 on 8/12/24.
//

import Foundation

/// 아.. 문제 조건을 잘못 파악했다....
/// 인센티브를 받지 못하는 것은, A 임원이 B 임원보다 근무태도, 동료 평가 모두 낮을 경우다.
///
/// A인원이 C인원보다 근무태도는 높아도 B인원보다 근무태도가 낮고, 동시에 동료 평가도 낮다면 A인원은
/// 인센티브를 받을 수 없게 되는 것이다......
///
/// 문제의 접근은 근무 태도를 가장 높은 우선순위로 소팅했을 때, 다음 element로 갈수록 근무 태도는 낮아진다.
///
/// 여기서 고려할 것은 동료평가 기준점과 같거나, 동료평가가 기준점보다 높아야 한다..
func solution(_ scores: [[Int]]) -> Int {
  let wanho = scores[0]
  let wanhoScore = wanho[0] + wanho[1]
  
  let sortedScores = scores.sorted {
    $0[0] != $1[0] ? $0[0] > $1[0] : $0[1] < $1[1]
  }
  
  var maxScore = 0
  var rank = 1
  for score in sortedScores {
    if wanho[0] < score[0] && wanho[1] < score[1] {
      return -1
    }
    
    /// 동료평가점수가 같거나 큰거에 한해서만 완호보다 큰 랭크를 결정해야함.
    /// 문제의 조건은 임의의 사원보다 두 점수가 '모두' 낮을 경우
    if score[1] >= maxScore {
      maxScore = score[1]
      if wanhoScore < score[0] + score[1] {
        rank += 1
      }
    }
  }
  
  return rank
}
print(solution([[2,2],[1,4],[3,2],[3,2],[2,1]]))
