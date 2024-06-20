//
//  main.swift
//  마법의 엘리베이터
//
//  Created by 양승현 on 6/20/24.
//

import Foundation

// 뀨!

func solution(_ storey:Int) -> Int {
  var floor = String(storey).map { Int(String($0))! }
  var count = 0
  while !floor.isEmpty {
    let sFloor = floor.removeLast()
    if sFloor == 0 { continue }
    if floor.isEmpty {
      if sFloor <= 5 {
        count += sFloor
      } else {
        count += 10-sFloor+1
      }
    } else {
      if sFloor >= 5 {
        if sFloor == 5 {
          count += 5
          if floor.last! < 5 {
            continue
          }
        }
        floor = String(Int(floor.map { String($0) }.joined(separator:""))! + 1).compactMap { Int(String($0)) }
        if sFloor > 5 {
          count += 10-sFloor
        }
      } else {
        count += sFloor
      }
    }
  }
  return count
}
