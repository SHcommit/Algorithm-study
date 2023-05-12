//
//  main.swift
//  [baekjoon]11478
//
//  Created by 양승현 on 2023/05/12.
//

import Foundation

var set = Set<String>()
let text = readLine()!.map{String($0)}
_=text.enumerated().map {
  var str = ""
  for i in $0.offset..<text.count {
    str += String(text[i])
    set.insert(str)
  }
}
print(set.count)
