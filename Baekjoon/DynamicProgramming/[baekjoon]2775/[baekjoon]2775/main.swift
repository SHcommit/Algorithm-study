//
//  main.swift
//  [baekjoon]2775
//
//  Created by 양승현 on 2023/05/09.
//

import Foundation

var res = ""
_=(0..<Int(readLine()!)!).map {_ in
  let kFloor = Int(readLine()!)!
  let ho = Int(readLine()!)!
  var list = Array((1...ho))
  for _ in 0..<kFloor {
    for j in 1..<ho {
      list[j] = list[j-1]+list[j]
    }
  }
  res += "\(list.last!)\n"
}
print(res)
