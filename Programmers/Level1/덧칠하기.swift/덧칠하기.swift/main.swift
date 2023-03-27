//
//  main.swift
//  덧칠하기.swift
//
//  Created by 양승현 on 2023/03/27.
//

import Foundation

func initPainted(target lists: inout [Bool], section: [Int]) {
  section.map {
    lists[$0 - 1] = false
  }
}
func drawPainted(lists: inout [Bool], m: Int, i: Int, n : Int) {
  for j in (i..<i+m) where j < n {
    lists[j] = true
  }
}
func solution(_ n:Int, _ m:Int, _ section:[Int]) -> Int {
  
  var painted = Array(repeating: true, count: n)
  var count = 0
  initPainted(target: &painted, section: section)
  (0..<n).map{ i in
    if !painted[i] {
      drawPainted(lists: &painted, m: m, i: i, n: n)
      count += 1
    }
  }
  
  return count
}
