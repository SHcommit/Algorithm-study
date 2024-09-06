//
//  main.swift
//  금과 은 운반하기
//
//  Created by 양승현 on 9/6/24.
//

import Foundation

/// 아.. 10^3 이게 xor이구나 ㅋㅋ;; pow쓰자. n제곱은. 깜빡했다잉
///
/// 문제가 어렵네,,,
///
/// 주요 로직은 parametric search사용해서 
/// 1. 최적화문제 -> 결정문제로 바꾼다!
/// 2. 가능한 시간을 이분탐색으로 구해나가자!
///
/// 이때 약간 마을별로 실어 날르는 무게는 동시성이다! 그래서 포문을 돌아서, 이분탐색을 통해 구한 mid가 시간이라고 생각하고 특정 "시간"대에
/// 모을수 있는 g 최대 양, s최대양 그리고 g+s 더한 값이 운반 가능한 값보다 큰지, 작은지를 정해주자.
///
/// 편도 + (시간 - 편도1회) * (왕복시간)*무게 이러면 특정 시간대에 옮길수 있는 무게가 탄생된다.
///
/// 마을별로 다 돌면, _g가 a보다 큰지, _s가 b보다 큰지. 왜? _s로만 운반할 경우도 있기 떄문에, _g의 최대값, _s의 누적 최대값을 구하는것이다.
///
/// 추가로 이건 한번 운반할때 지정된 weight 안에서 금 + 은을 싣을 수 있기 때문에 _g + _s or availableWeight의 min의 최대 값인 total이 (a+b)보다 큰지도 구하면 된다.
func solution(_ a:Int, _ b:Int, _ g:[Int], _ s:[Int], _ w:[Int], _ t:[Int]) -> Int64 {
  var l = 1, r = Int(exactly: pow(10.0, 14.0))!*4, m = 0
  while l<=r {
    m = (l+r)/2
    
    var _g = 0, _s = 0, total = 0
    for i in g.indices {
      if t[i] > m { continue }
      let availableWeight = w[i] + (m-t[i])/(2*t[i])*w[i]
      _g += min(availableWeight, g[i])
      _s += min(availableWeight, s[i])
      total += min(availableWeight, g[i] + s[i])
    }
    
    if _g >= a && _s >= b && total >= (a+b) {
      r = m - 1
    } else {
      l = m + 1
    }
  }
  return Int64(l)
}
