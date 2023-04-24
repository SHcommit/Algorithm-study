//
//  main.swift
//  [baekjoon]4796
//
//  Created by 양승현 on 2023/04/24.
//

import Foundation

var c=0
while let input=readLine() {
  if input=="0 0 0" { break }
  let s = input.split{$0==" "}.map{Int($0)!}
  c+=1
  print("Case \(c): \(((s[2]/s[1]*s[0]) + min(s[0],s[2]%s[1])))")
}
