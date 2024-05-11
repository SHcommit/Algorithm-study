//
//  main.swift
//  The_Most_received_Gift
//
//  Created by 양승현 on 5/11/24.
//

import Foundation

func solution(_ friends:[String], _ gifts:[String]) -> Int {
  var giftTable: [[Int]] = Array(repeating: Array(repeating: 0, count: friends.count), count: friends.count)
  var giftFigures: [Int] = []
  var res: [Int] = Array(repeating: 0, count: friends.count)
  
  gifts.forEach { gift in
    let giftsAndReceives = gift.split { $0==" " }.compactMap { String($0) }
    let gifterIdx = friends.firstIndex(where: { $0 == giftsAndReceives[0] })!
    let receiverIdx = friends.firstIndex(where: { $0 == giftsAndReceives[1] })!
    giftTable[receiverIdx][gifterIdx] += 1
  }
  
  giftFigures = (0..<friends.count).map { giverIdx in
    var totalGiveCount = 0
    var totalReceiveCount = 0
    for receiverIdx in 0..<friends.count {
      if receiverIdx == giverIdx { continue }
      totalGiveCount += giftTable[receiverIdx][giverIdx]
      totalReceiveCount += giftTable[giverIdx][receiverIdx]
    }
    return totalGiveCount - totalReceiveCount
  }
  for giverIdx in 0..<friends.count {
    for receiverIdx in 0..<friends.count {
      if giverIdx == receiverIdx { continue }
      /// a 가 b한테 준경우, b가 a한테 준 경우보다 크다면,
      if giftTable[receiverIdx][giverIdx] > giftTable[giverIdx][receiverIdx] {
        res[giverIdx] += 1
        
        /// 0이거나 주고받은 횟수가 같은 경우
      } else if giftTable[receiverIdx][giverIdx] == giftTable[giverIdx][receiverIdx] {
        if giftFigures[giverIdx] > giftFigures[receiverIdx] {
          res[giverIdx] += 1
        }
      }
    }
  }
  return res.max() ?? 0
}

print(solution(
  ["joy", "brad", "alessandro", "conan", "david"],
  ["alessandro brad", "alessandro joy", "alessandro conan", "david alessandro", "alessandro david"]))
