//
//  main.swift
//  모의고사
//
//  Created by 양승현 on 8/17/24.
//

import Foundation

func solution(_ answers:[Int]) -> [Int] {
  let patterns = [
    "12345".compactMap { Int(String($0)) },
    "21232425".compactMap { Int(String($0)) },
    "3311224455".compactMap { Int(String($0)) }
  ]
  let scores = patterns.map { pattern in answers.enumerated().filter { pattern[$0%pattern.count] == $1 }.count }
  let maxScore = scores.max()!
  return scores.enumerated().filter { $0.1 == maxScore }.map { $0.0 + 1 }.sorted()
}
