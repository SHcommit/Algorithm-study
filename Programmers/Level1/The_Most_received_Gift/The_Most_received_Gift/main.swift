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
  let giftsAndReceives = gifts.map { gift in
    gift.split { $0==" " }.compactMap { String($0) }
  }
  giftsAndReceives.forEach { giftAndReceive in
    let gifterIdx = friends.firstIndex(where: { $0 == giftAndReceive[0] })!
    let receiverIdx = friends.firstIndex(where: { $0 == giftAndReceive[1] })!
    giftTable[receiverIdx][gifterIdx] += 1
  }
  giftFigures = (0..<friends.count).map { index in
    var totalGiveCount = 0
    var totalReceiveCount = 0
    for i in 0..<friends.count {
      if i == index { continue }
      totalGiveCount += giftTable[i][index]
      totalReceiveCount += giftTable[index][i]
    }
    return totalGiveCount - totalReceiveCount
  }
  var res: [Int] = Array(repeating: 0, count: friends.count)
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
