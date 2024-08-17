//
//  main.swift
//  다리를 지나는 트럭
//
//  Created by 양승현 on 8/17/24.
//

import Foundation

/// 최악의 경우 10,000 * 10,000 == 10,000,000 이라서 브루트 포스 느낌으로..
/// 와일문 돌 때마다 다리위 트럭이 실리거나, 아무것도 없음을 나타내는 0을 추가했다.
///
/// bridge는 bridge_length만큼만 로드할 수 있고, 브릿지의 bridge_length길이가 되는 element는 다리에서 빠져나온거로 간주해서 뺀다. 이때 실시간으로 다리위의 무게는
/// 감소되어, 동시에 새로운 트럭이 다리 위에 올라갈 수 있도록 구현해봤따.따따따!!
func solution(_ bridge_length:Int, _ weight:Int, _ truck_weights:[Int]) -> Int {
  var trucks = truck_weights
  var during = 1
  var currentWeight = trucks.removeFirst()
  var bridge: [Int] = Array(repeating: 0, count: bridge_length)
  bridge[0] = currentWeight
  while !trucks.isEmpty || currentWeight != 0 {
    during += 1
    let removed = bridge.removeLast()
    if removed != 0 {
      currentWeight -= removed
    }
    if currentWeight < weight, let first = trucks.first, first + currentWeight <= weight {
      bridge.insert(trucks.removeFirst(), at: 0)
      currentWeight += bridge[0]
    } else {
      bridge.insert(0, at: 0)
    }
  }
  
  return during
}


print(solution(100, 100, [10,10,10,10,10,10,10,10,10,10]))
