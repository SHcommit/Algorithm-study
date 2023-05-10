//
//  main.swift
//  [baekjoon]11651
//
//  Created by 양승현 on 2023/05/10.
//

import Foundation

var a=(0..<Int(readLine()!)!).map {_ in
  return readLine()!.split{$0==" "}.map{Int(String($0))!}
}
print(a.sorted { $0[1]==$1[1] ? $0[0]<$1[0] : $0[1]<$1[1] }.map{$0.map{String($0)}.joined(separator: " ")}.joined(separator:"\n"))
