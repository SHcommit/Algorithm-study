//
//  main.swift
//  [baekjoon]3003
//
//  Created by 양승현 on 2023/06/24.
//

import Foundation

let input = readLine()!.split{$0==" "}.map { Int(String($0))! }
print([1, 1, 2, 2, 2, 8].enumerated().map { index, x -> String in
  return String(x - input[index])
}.joined(separator: " "))
