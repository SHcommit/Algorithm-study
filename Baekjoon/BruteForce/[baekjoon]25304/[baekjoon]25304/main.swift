//
//  main.swift
//  [baekjoon]25304
//
//  Created by 양승현 on 2023/06/01.
//

import Foundation
let m = Int(readLine()!)!, n = Int(readLine()!)!
print(m == (0..<n).reduce(0) { p, n in
  return p + readLine()!.split{$0==" "}.map{Int(String($0))!}.reduce(1,*)
} ? "Yes" : "No")
