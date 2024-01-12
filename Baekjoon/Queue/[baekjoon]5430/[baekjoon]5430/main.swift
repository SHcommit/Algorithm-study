//
//  main.swift
//  [baekjoon]5430
//
//  Created by 양승현 on 1/12/24.
//

import Foundation

(0..<Int(readLine()!)!).forEach { _ in s() }
func s() {
  let p = readLine()!.map {String($0)}
  let n = Int(readLine()!)!
  var isReversed = false
  var f = 0, r = n-1
  let seq = readLine()!.replacingOccurrences(of: "[\\[\\]]", with: "", options: .regularExpression).split{$0==","}.map{String($0)}
  if n == 0 {
    print( p.contains("D") ? "error" : "[]")
    return
  }
  for (i,c) in p.enumerated() {
    if c == "D" {
      if isReversed {
        r -= 1
      } else {
        f += 1
      }
    } else {
      isReversed.toggle()
    }
    if i+1 == p.count && f-r >= 1 {
      print("[]")
      return
    }
    if f > r {
      print("error")
      return
    }
  }
  if isReversed {
    print("["+stride(from: r, through: f, by: -1).map{seq[$0]}.joined(separator: ",")+"]")
  } else {
    print("["+seq[f...r].joined(separator: ",")+"]")
  }
}
