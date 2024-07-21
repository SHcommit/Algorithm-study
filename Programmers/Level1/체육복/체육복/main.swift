//
//  main.swift
//  체육복
//
//  Created by 양승현 on 7/21/24.
//

import Foundation

/// 엥.. 당연히 lost, reserve는 sort되서 주는줄 알았는데 아니었다.
/// 그러나 또 문제에선 정렬해서 준다고도 하지 않았음. OTL
/// 앞으로 문제에서 주어진 값이 정렬된다느 말이 없지만, 난 정렬된 input을 사용해야만 할 때는 정렬 한번 확실하게 해주는것도 좋을것 같다.
///
/// 난 투포인터로 풀었다.
/// 여벌을 가져왔는데 자신도 도난당했으면 그런거는 미리 필터를 통해 제거했다. (duplicates에 그 개수를 저장해서 나중에 더해줌)

func solution(_ n:Int, _ lost:[Int], _ reserve:[Int]) -> Int {
  var matchedTempClothes = 0, rIdx = 0, lIdx = 0
  let llost = lost.filter { !reserve.contains($0) }.sorted()
  let rreserve = reserve.filter { !lost.contains($0) }.sorted()
  let duplicates = lost.filter { reserve.contains($0) }.count
  while rIdx < rreserve.count && lIdx < llost.count {
    let lo = llost[lIdx], re = rreserve[rIdx]
    if abs(lo - re) <= 1 {
      matchedTempClothes += 1
      rIdx += 1
      lIdx += 1
    } else if lo > re {
      rIdx += 1
    } else {
      lIdx += 1
    }
  }
  return n - lost.count + matchedTempClothes + duplicates
}
