//
//  main.swift
//  할인 행사
//
//  Created by 양승현 on 7/4/24.
//

import Foundation

/// 문제는 나쁘지않았는데, 이 문자열들을 다 딕셔너리로 풀어보고 싶었다.
///
/// 행사 기간을 0일 ... 행사 마지막일 - 10일 을 시작으로해서 접근할때 reduce를 사용해서 O(n^2)로 하지않고
/// 누적합을 사용해서 O(n)으로 해부렸다.
///
/// 그런데 아쉬웠던 점은 이렇게 설계를 했는데 xcode에서 디버깅 하지않았다면, 실제로 어디에서 코드를 빼뜨리지 않았는지 파악할 방법이 프로그래머스에선 없다.
///
/// 나는 wants 구현할 때 딕셔너리에 값을 number값으로 대응시켜야햇는데, 실수로 enumerated()의 n 값을 넣어버렸다.
///
/// 또한 딕셔너리를 사용할때는 옵셔널로 반환되기에 옵셔널 체이닝을 잘 해야한다. 그렇지 않으면 컴파일 추론이 잘 안되네,, 그리고 클로저 쓸때도 반환타입 명시해서 추론 잘되게 하자.
func solution(_ want:[String], _ number:[Int], _ discount:[String]) -> Int {
  typealias Product = [String: Int]
  let keys = Array(Set(want))
  let wants = want.enumerated().reduce(into: Product()) { $0[$1.1] = number[$1.0] }
  var prefixSumDays: [Product] = (0...discount.count).map { i in
    var dict: Product
    dict = keys.reduce(into: [String: Int]()) { $0[$1] = 0 }
    if i > 0 {
      dict[discount[i-1], default: 0] += 1
    }
    return dict
  }
  for i in 1...discount.count {
    keys.forEach { key in
      prefixSumDays[i][key] = (prefixSumDays[i][key] ?? 0) + (prefixSumDays[i-1][key] ?? 0)
    }
  }
  return (0...discount.count-10).map { s -> Bool in
    var e = s+10
    if e > discount.count {
      e = discount.count
    }
    let promotionTotalDay: Product = prefixSumDays[e].keys.reduce(into: Product()) {
      $0[$1] = (prefixSumDays[e][$1] ?? 0) - (prefixSumDays[s][$1] ?? 0)
    }
    for key in wants.keys {
      if wants[key] ?? 0 > promotionTotalDay[key] ?? 0 {
        return false
      }
    }
    return true
  }.filter{ $0 }
    .count
}

print(solution(["banana", "apple", "rice", "pork", "pot"], [3, 2, 2, 2, 1],
               ["chicken", "apple", "apple", "banana", "rice", "apple", "pork", "banana", "pork", "rice", "pot", "banana", "apple", "banana"]))

