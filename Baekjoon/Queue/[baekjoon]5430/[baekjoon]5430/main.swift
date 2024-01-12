//
//  main.swift
//  [baekjoon]5430
//
//  Created by 양승현 on 1/12/24.
//

import Foundation
(0..<Int(readLine()!)!).forEach { _ in
  s()
}
func s() {
  let p = readLine()!.map {String($0)}
  let n = Int(readLine()!)!
  var isReversed = false
  var isError = false
  var front = 0, rear = n-1
  let seq = readLine()!.replacingOccurrences(of: "[\\[\\]]", with: "", options: .regularExpression).split{$0==","}.map{String($0)}
  if n == 0 {
    if p.contains("D") {
      print("error")
      return
    }
    print("[]")
    return
  }
  for (i,c) in p.enumerated() {
    if c == "D" {
      if isReversed {
        rear -= 1
      } else {
        front += 1
      }
    } else {
      isReversed.toggle()
    }
    if i+1 == p.count && front-rear >= 1 {
      print("[]")
      return
    }
    if front > rear {
      print("error")
      isError.toggle()
      break
    }
  }
  if isError { return }
  if isReversed {
    print("["+stride(from: rear, through: front, by: -1).map{seq[$0]}.joined(separator: ",")+"]")
  } else {
    print("["+seq[front...rear].joined(separator: ",")+"]")
  }
}
