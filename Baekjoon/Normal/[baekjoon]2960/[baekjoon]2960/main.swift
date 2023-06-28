//
//  main.swift
//  [baekjoon]2960
//
//  Created by 양승현 on 2023/06/28.
//

import Foundation

let input = readLine()!.split{$0==" "}.map{Int(String($0))!}
let (n,k) = (input[0],input[1])
var cnt = 0
var check = Array(repeating: true, count: n+1)
for i in 2...n {
  for j in stride(from: i, through: n, by: i)  where check[j] {
    check[j] = false
    cnt += 1
    if cnt == k {
      print(j)
      break
    }
  }
}
