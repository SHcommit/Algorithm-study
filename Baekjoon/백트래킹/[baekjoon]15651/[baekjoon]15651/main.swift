//
//  main.swift
//  [baekjoon]15651
//
//  Created by 양승현 on 2022/05/03.
//

import Foundation
let nm = readLine()!.split{$0==" "}.map { Int(String($0))!}
func execute(_ k: [String]) {
  if k.count == nm[1] {
    print(k.joined(separator: " "))
    return
  }
  _=(1...nm[0]).map{execute(k+[String($0)])}
}
execute([])
