//
//  main.swift
//  [baekjoon]2204
//
//  Created by 양승현 on 2023/05/07.
//

import Foundation

var n = Int(readLine()!)!
var res = ""
while n != 0{
  var arr = [String]()
  for _ in 0..<n{ arr.append(readLine()!) }
  res += "\(arr.sorted { $0.lowercased() < $1.lowercased() }.first!)\n"
  n = Int(readLine()!)!
}
print(res)
