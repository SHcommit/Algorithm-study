//
//  main.swift
//  [baekjoon]2857
//
//  Created by 양승현 on 2023/03/29.
//

import Foundation
var arr: [String] = []
_=(1..<6).map{
  if readLine()!.contains("FBI") { arr.append(String($0))}
}
print(arr.isEmpty ? "HE GOT AWAY!" : arr.joined(separator: " "))
