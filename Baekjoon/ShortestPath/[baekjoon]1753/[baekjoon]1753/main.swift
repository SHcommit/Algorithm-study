//
//  main.swift
//  [baekjoon]1753
//
//  Created by 양승현 on 2022/03/17.
//

import Foundation

var VE = readLine()!.split(separator: " ").map{Int($0)!}
var startVertex = Int(readLine()!)!
var graph : [[Int]] = Array(repeating: Array(repeating: 0, count: 0), count: VE[0] + 1)
for i in 0..<VE[1]{
    var uvw = readLine()!.split(separator: " ").map{Int($0)!}
}
