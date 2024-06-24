//
//  main.swift
//  크기가 작은 부분문자열
//
//  Created by 양승현 on 6/24/24.
//

import Foundation

func solution(_ t:String, _ p:String) -> Int {
  let t = t.map { String($0) }, pCnt = p.count, pInt = Int(p)!
  return (0...(t.count - pCnt)).reduce(0) {
    if Int(t[$1..<(pCnt+$1)].joined(separator: ""))! <= pInt { return $0 + 1 }
    return $0
  }
}

print(solution("500220839878", "7"))
