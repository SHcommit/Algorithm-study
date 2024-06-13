//
//  main.swift
//  둘만의 암호
//
//  Created by 양승현 on 6/13/24.
//

import Foundation

let alphabet = "abcdefghijklmnopqrstuvwxyz".map { String($0) }
var skip: [String] = []

func solution(_ s:String, _ inputSkip:String, _ index:Int) -> String {
  skip = inputSkip.map { String($0) }
  return s.map {
    let char = String($0)
    var startIdx: Int = alphabet.firstIndex(of: char)!
    var endIdx = startIdx + index
    var skipCnt = Int.max
    while skipCnt != 0 {
      skipCnt = handleSkip(from: startIdx, to: endIdx)
      startIdx = (endIdx + 1) % alphabet.count
      endIdx = (endIdx + skipCnt) % alphabet.count
    }
    return alphabet[endIdx]
  }.joined(separator: "")
}

@inline(__always)
func handleSkip(from: Int, to: Int) -> Int {
  var _to: Int = to
  if to >= alphabet.count {
    var skipCount = 0
    _to = to - alphabet.count
    skipCount += numberOfSkips(from: from, to: alphabet.count-1)
    skipCount += numberOfSkips(from: 0, to: _to)
    return skipCount
  }
  if from <= to {
    return numberOfSkips(from: from, to: to)
  }
  else {
    var skipCount = 0
    skipCount += numberOfSkips(from: from, to: alphabet.count-1)
    skipCount += numberOfSkips(from: 0, to: to)
    return skipCount
  }}

@inline(__always)
func numberOfSkips(from: Int, to: Int) -> Int {
  var skipCnt = 0
  alphabet[from...to].forEach { c in
    if skip.contains(where: { $0 == c }) { skipCnt += 1 }
  }
  return skipCnt
}

print(solution("yz", "ac", 2))
print(solution("aukks", "wbqd", 5))
