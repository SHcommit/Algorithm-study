//
//  main.swift
//  택배 배달과 수거하기
//
//  Created by 양승현 on 6/20/24.
//

import Foundation

/// 틀렸던 이유1 :
/// ```
/// if lastHomeIdx == 0 {
///   if ... {
///       break를 하지 않아서, 끝나야할 상황에서도 계속 하위 로직들 수행됨 +2씩 답에 추가.
///   }
/// }
/// ```
/// 틀렸던 이유2 :
/// carry 구간에서 분기처리를 if { } if { } else { } 이렇게했는데, 확실하게 if{ } else if{ } else { }이렇게해야 좋다.
/// if { } if { }이 조건이 아닌데, break를 처음에 걸어두지 않게되면 2번의, 조건이 연이어 처리되기 때문. 난 한번의 조건 탐색만을 원했는데
func solution(_ cap:Int, _ n:Int, _ deliveries:[Int], _ pickups:[Int]) -> Int64 {
  var deliveries = deliveries
  var pickups = pickups
  var moving = 0
  var lastHomeIdx = n-1
  var maxDeliveriesIdx = n-1
  var maxPickupsIdx = n-1
  while lastHomeIdx >= 0 {
    maxDeliveriesIdx = hasContainAnySuppliesIdx(deliveries, lastHomeIdx: maxDeliveriesIdx)
    maxPickupsIdx = hasContainAnySuppliesIdx(pickups, lastHomeIdx: maxPickupsIdx)
    lastHomeIdx = max(maxDeliveriesIdx, maxPickupsIdx)
    if lastHomeIdx == 0 {
      if deliveries[0] <= 0 && pickups[0] <= 0 {
        break
      }
    }
    carry(&deliveries, fromLastHome: maxDeliveriesIdx, withCap: cap)
    carry(&pickups, fromLastHome: maxPickupsIdx, withCap: cap)
    moving += (lastHomeIdx + 1) * 2
  }
  return Int64(moving)
}

func hasContainAnySuppliesIdx(_ arr: [Int], lastHomeIdx: Int) -> Int {
  for i in stride(from: lastHomeIdx, through: 0, by: -1) {
    if arr[i] > 0 {
      return i
    }
  }
  return 0
}

func carry(_ arr: inout [Int], fromLastHome lastHome: Int, withCap cap: Int) {
  var lastHomeIdx = lastHome
  var cap = cap
  while lastHomeIdx >= 0 && cap > 0 {
    if arr[lastHomeIdx] == 0 {
      lastHomeIdx -= 1
    } else if arr[lastHomeIdx] >= cap {
      arr[lastHomeIdx] -= cap
      break
    } else {
      arr[lastHomeIdx] -= cap
      cap = abs(arr[lastHomeIdx])
      lastHomeIdx -= 1
    }
  }
}
