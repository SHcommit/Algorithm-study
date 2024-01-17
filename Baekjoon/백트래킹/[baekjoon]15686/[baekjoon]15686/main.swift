//
//  main.swift
//  [baekjoon]15686
//
//  Created by 양승현 on 1/17/24.
//

// 9:19 -> 9:48 -> 54 -> 58 -> 22 sol.
import Foundation

/*
  아흑.. 잘했는데 나만의 식을 세워봄.
 1. 백트래킹으로 지역 샵 중 m개 선택하기
 2. 샵에서 치킨거리 계산하기
 
 근데 여기서 문제는 백트래킹 구할 때 k+1을 할 때 백트레킹 함수 호출하는 부분에다가 i가아니라
 k를 넣어버렸음;;ㅠㅠㅠㅠㅠㅠ
 그래도 나쁘지않았다.
 
 */

typealias Point = (x:Int, y:Int)
let nm = readLine()!.split{$0==" "}.map{Int($0)!}
var shops: [Point] = []
var houses: [Point] = []
var ans = Int.max
(0..<nm[0]).forEach { y in
  readLine()!.split{$0==" "}.map{Int($0)!}.enumerated().forEach {
    if $0.element == 1 {
      houses.append(Point(x:$0.offset,y:y))
    } else if $0.element == 2 {
      shops.append(Point(x:$0.offset,y:y))
    }
  }
}

func backtracking(from k: Int, withSeq seq: [Point]) {
  if seq.count == nm[1] {
    calculate(from: seq)
    return
  }
  for i in k..<shops.count {
    backtracking(from: i+1, withSeq: seq + [shops[i]])
  }
}

func calculate(from selectedShops: [Point]) {
  var accumulated = 0
  houses.forEach { house in
    var cost = Int.max
    selectedShops.forEach {
      cost = min(cost, abs($0.x-house.x)+abs($0.y-house.y))
    }
    accumulated += cost
  }
  ans = min(ans, accumulated)
}

backtracking(from: 0, withSeq: [])
print(ans)
