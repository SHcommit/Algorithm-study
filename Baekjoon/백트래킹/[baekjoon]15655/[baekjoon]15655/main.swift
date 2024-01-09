//
//  main.swift
//  [baekjoon]15655
//
//  Created by 양승현 on 1/9/24.
//

import Foundation

let nm = readLine()!.split{$0==" "}.map{Int(String($0))!}
let list = readLine()!.split{$0==" "}.map{Int(String($0))!}.sorted()
let s: ([Int]) -> Void = {
  if $0.count == nm[1] { print($0.map{String($0)}.joined(separator:" ")); return; }
  for i in list where $0.last ?? 0 < i {s($0+[i])}
}
s([])
