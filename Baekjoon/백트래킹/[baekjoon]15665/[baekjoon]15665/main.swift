//
//  main.swift
//  [baekjoon]15665
//
//  Created by 양승현 on 1/14/24.
//

import Foundation
let nm = readLine()!.split{$0==" "}.map{Int($0)}
let l = readLine()!.split{$0==" "}.map{Int($0)!}.sorted().map {String($0)}
var cached = Set<String>()
var res=""
func r(_ s: String, _ len: Int) {
  for e in l {
    let t=s+"\(e) "
    if len+1 == nm[1] {
      if cached.contains(t){continue}
      cached.insert(t)
      res+=t+"\n"
      continue
    }
    r(t, len+1)
  }
}
r("",0)
print(res)
