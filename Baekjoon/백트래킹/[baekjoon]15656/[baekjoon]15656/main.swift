//
//  main.swift
//  [baekjoon]15656
//
//  Created by 양승현 on 1/9/24.
//

import Foundation
let nm=readLine()!.split{$0==" "}.map{Int($0)!}
let l=readLine()!.split{$0==" "}.map{Int($0)!}.sorted().map{String($0)}
var r = ""
let s:([String])->Void={
  if $0.count == nm[1]{r += $0.joined(separator: " ") + "\n";return;}
  for i in l {s($0+[i])}
}
s([])
print(r)
