//
//  main.swift
//  [baekjoon]2217
//
//  Created by 양승현 on 2023/05/04.
//

import Foundation
        
print(
  (0..<Int(readLine()!)!)
  .map{_ in Int(readLine()!)!}
  .sorted(by: >)
  .enumerated()
  .map{($0+1)*$1}
  .max()!)
