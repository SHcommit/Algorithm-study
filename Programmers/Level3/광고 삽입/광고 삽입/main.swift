//
//  main.swift
//  광고 삽입
//
//  Created by 양승현 on 9/3/24.
//

import Foundation

/// 누적합을 이용하긔
func solution(_ playTime:String, _ advTime:String, _ logs:[String]) -> String {
  if playTime == advTime {
    return "00:00:00"
  }
  let playSec = playTime.toSec()
  let advSec = advTime.toSec()
  var delta = Array(repeating: 0, count: playSec+1)
  logs.map(toStartAndEndSec).forEach { play in
    delta[play[0]]+=1
    delta[play[1]]-=1
  }
  
  let prefixSum = makePrefixSum(from: delta)
  
  var currentViewSec = (0..<advSec).reduce(0) { prefixSum[$1]+$0 }
  var maxViewSec = currentViewSec
  var maxStartSec = 0
  
  for start in 1...(playSec-advSec) {
    currentViewSec = currentViewSec - prefixSum[start-1] + prefixSum[start-1+advSec]
    if currentViewSec > maxViewSec {
      maxStartSec = start
      maxViewSec = currentViewSec
    }
  }
  
  return maxStartSec.secToHHMMSS()
}

extension Int {
  func secToHHMMSS() -> String {
    let h = self/(60*60)
    let m = (self%(60*60))/60
    let s = self % 60
    return [h,m,s].map { String(format: "%02d",$0) }.joined(separator: ":")
  }
}

extension String {
  func toSec() -> Int {
    let splitted = split{$0==":"}.compactMap{Int(String($0))}
    return splitted[0]*60*60 + splitted[1]*60 + splitted[2]
  }
}

func toStartAndEndSec(from: String) -> [Int] {
  return from.split{$0=="-"}.map { String($0).toSec() }
}

func makePrefixSum(from delta: [Int]) -> [Int] {
  var res = delta
  for i in 1..<delta.count {
    res[i] += res[i-1]
  }
  return res
}
