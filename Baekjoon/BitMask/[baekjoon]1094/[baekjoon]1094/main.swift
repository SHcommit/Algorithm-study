//
//  main.swift
//  [baekjoon]1094
//
//  Created by 양승현 on 2023/03/25.
//

import Foundation

var count = 0;
var n = 64;
var x = Int(readLine()!)!

while x > 0 {
  if n > x {
    n /= 2
  }else if n <= x {
    count += 1
    x -= n
  }
}
print(count)
