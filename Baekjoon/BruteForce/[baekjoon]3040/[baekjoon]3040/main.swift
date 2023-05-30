//
//  main.swift
//  [baekjoon]3040
//
//  Created by 양승현 on 2023/05/30.
//

import Foundation
let list = (0..<9).map {_ in Int(readLine()!)!}
let sum = list.reduce(0,+)
for i in 0..<8 {
  for j in i+1..<9 where sum - list[i] - list[j] == 100{
    print(list
      .filter {![list[i],list[j]].contains($0)}
      .map { String($0) }
      .joined(separator: "\n"))
    exit(0)
  }
}
