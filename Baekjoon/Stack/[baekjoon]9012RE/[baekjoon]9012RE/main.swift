//
//  main.swift
//  [baekjoon]9012RE
//
//  Created by 양승현 on 2023/06/03.
//

import Foundation

_=(0..<Int(readLine()!)!).map {_ in
  print(isVPS(readLine()!.map{String($0)}) ? "YES" : "NO")
}
func isVPS(_ s: [String]) -> Bool {
  return s.reduce([]) {
    if $1 == ")" {
      if let p = $0.last, "\(p)" == "(" {
        return Array($0.dropLast())
      }
    }
    return $0 + [$1]
  }.isEmpty
}
