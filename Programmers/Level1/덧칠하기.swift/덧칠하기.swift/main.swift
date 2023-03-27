//
//  main.swift
//  덧칠하기.swift
//
//  Created by 양승현 on 2023/03/27.
//

import Foundation

func solution(_ n:Int, _ m:Int, _ section:[Int]) -> Int {
  
  var painted = Array(repeating: true, count: n)
  section.map {
    painted[$0 - 1] = false
  }
  var count = 0
  (0..<n).map{ i in
    if !painted[i] {
      for j in (i..<i+m) where j < n {
        painted[j] = true
      }
      count += 1
    }
  }
  
  return count
}
