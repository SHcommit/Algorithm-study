//
//  main.swift
//  [Baekjoon]24416
//
//  Created by 양승현 on 2023/05/24.
//

import Foundation

var s=[0,1]
print((1...Int(readLine()!)!).map { i->Int in
  if i==1 { return s[1] }
  s.append(s[i-1]+s[i-2])
  return s.last!
}.max()!)
