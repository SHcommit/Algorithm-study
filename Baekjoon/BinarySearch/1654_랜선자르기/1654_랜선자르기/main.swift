//
//  main.swift
//  1654_랜선자르기
//
//  Created by 양승현 on 9/4/24.
//

import Foundation

/// 다시 돌아온 랜선 자르기!
/// 어떻게 짤라야 잘 짤랐다고 소문이날까...
///
/// 언제까지 짤라야할까?..
///
/// 적정선을 넘지않는 하에 최대한의 길이를 구해나간다.
/// m은 특정하게 잘랐을때의 길이라고 본다면, n보다 크다면?  m이 더 커져도된다.
/// n이 더 크다면? r을 작게해줘야한다. 이러면서 알아서 적정선을 구해나가야하는데
///
/// 이때 한가지 무한루프에빠질수있는게 l이 r보다 작도록 해두면안된다.
let kn = readLine()!.split{$0==" "}.compactMap { Int(String($0)) }
let k = kn[0], n = kn[1]
let ropes = (0..<k).map { _ in Int(readLine()!)! }
func binarySearch() -> Int {
  var l = 1, r = ropes.max()!
  while l<=r {
    var m = (l+r)/2
    if ropes.reduce(0) { $0 + $1/m } >= n {
      l = m + 1
    } else {
      r = m - 1
    }
  }
  return l
}
print(binarySearch() - 1 )
