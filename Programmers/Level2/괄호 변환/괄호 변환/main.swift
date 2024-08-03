//
//  main.swift
//  괄호 변환
//
//  Created by 양승현 on 8/3/24.
//

import Foundation

/// 아닛.. 문제가... 괄호 뒤집기가 reversed가 아니라 seq 각각 원소의 반대로 전환하는거였음.
/// 문제의 요구사항대로 구현하긔!
func solution(_ p:String) -> String {
  /// u
  var buf: [String] = []
  var cnt = 0
  if p.isEmpty { return "" }
  for char in p {
    let char = String(char)
    if buf.isEmpty || buf.first == char {
      buf.append(char)
      cnt += 1
      continue
    }
    buf.append(char)
    cnt -= 1
    if cnt == 0 { break }
  }
  
  let otherStartIdx = p.index(p.startIndex, offsetBy: buf.count)
  /// v
  let suffix = String(p[otherStartIdx...])
  if isCorrect괄호(buf) {
    return buf.joined() + solution(suffix)
  }
  buf.removeFirst(); buf.removeLast()
  return "(" + solution(suffix) + ")" + buf.map { $0 == "(" ? ")" : "(" }.joined()
}

func isCorrect괄호(_ seq: [String]) -> Bool {
  if seq.isEmpty { return false }
  var stack: [String] = []
  for char in seq {
    if char == "(" {
      stack.append(char)
    } else {
      if stack.popLast() == nil {
        return false
      }
    }
  }
  return stack.isEmpty
}
