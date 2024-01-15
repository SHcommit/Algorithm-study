//
//  main.swift
//  [baekjoon]15666
//
//  Created by 양승현 on 1/15/24.
//

import Foundation
let nm = readLine()!.split{$0==" "}.map{Int($0)!}
let l = Set(readLine()!.split{$0==" "}.map{Int($0)!}).sorted()
func s(_ seq:[Int]) {
  if seq.count==nm[1]{print(seq.map{String($0)}.joined(separator: " "))}
  else{_=l.map{if (seq.last ?? 0)<=$0{s(seq+[$0])}}}
}
s([])
