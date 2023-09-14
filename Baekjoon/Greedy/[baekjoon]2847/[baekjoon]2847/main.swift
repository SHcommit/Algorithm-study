//
//  main.swift
//  [baekjoon]2847
//
//  Created by 양승현 on 2023/09/14.
//

/**
 -  문제 요약
 
 총 N개의 레벨.
 레벨 클리어 시 점수 주어짐.
 
 플레이어 점수는 점수의 합을 바탕으로 온라인 순위 매겨짐.
 레벨을 난이도 순으로 만들음. 근데 실수로 쉬운 레벨일 수록 더 많은 점수를 받음.
 
 이 문제 해결하기 위해 동준이는 특정 레벨의 점수 감소하려고 함. ==> 각 레벨 클리어 시 주는 점수 증가하도록.
 
 각 레벨 클리어할 때 얻는 점수를 몇버 ㄴ감소해야, 각 레벨 클리어시 주는 점수가 증가하는지 구하시오. 점수 내리는 경우를 최소한으로.
 
 
 - 느낀점
 이 문제 접근할 때 뒤에서부터 접근하면 어떨까?
 최소한으로 level을 낮춰야한다면, 아래 지정된 레밸보다 상위에 지정해야할 레벨은 이전 레벨보다 -1 작으면 된다.
 
 이게 그리디인가..?
 */
import Foundation

let n = Int(readLine()!)!
var levels = (0..<n).map { _ in Int(readLine()!)! }
var res = 0
for i in stride(from: n-2, through: 0, by: -1) where levels[i+1] <= levels[i] {
  res += levels[i] - levels[i+1] + 1
  levels[i] = levels[i+1]-1
}
print(res)
