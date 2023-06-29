//
//  main.swift
//  [baekjoon]27433
//
//  Created by 양승현 on 2023/06/29.
//

import Foundation

func fact(_ num: Int) -> Int {
  if num == 1 || num == 0 { return 1 }
  return num * fact(num-1)
}
print(fact(Int(readLine()!)!))
