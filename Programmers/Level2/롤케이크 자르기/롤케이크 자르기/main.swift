//
//  main.swift
//  롤케이크 자르기
//
//  Created by 양승현 on 7/1/24.
//

import Foundation

/// 동생은 n-1, 형은 n개까지. 이렇게 2중 포문으로 해볼까했는데 O(n^2)이고 1,000,000,000,000의 연산이 든다.
///
/// 시간복잡도를 어떻게 줄일까 생각했는데
/// 왼쪽 + 오른쪽 각각에서부터 각각 토핑 개수새고 O(n)
/// 동생이 i...n-1까지 갖는 경우 각각 세었던 토핑 개수를 비교하며 같은지로 풀었다.
/// O(2n) == O(n)인 셈이다.
func solution(_ topping:[Int]) -> Int {
  let count = topping.count
  var lTemp = Set<Int>()
  var rTemp = Set<Int>()
  var res = 0
  var l: [Int] = [], r = l
  for i in topping.indices {
    lTemp.insert(topping[i])
    rTemp.insert(topping[count-1-i])
    l.append(lTemp.count)
    r.append(rTemp.count)
  }
  for i in topping.indices {
    if count - i - 2 < 0 {
      break
    }
    if l[i] == r[count-i-2] { res += 1 }
  }
  return res
}

print(solution([1,2,1,3,1,4,1,2]))
