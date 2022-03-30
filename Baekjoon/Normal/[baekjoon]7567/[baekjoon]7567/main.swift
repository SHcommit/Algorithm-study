//  main.swift
//  [baekjoon]7567
//  Created by 양승현 on 2022/03/30.


import Foundation
var seq = readLine()!.map{String($0)}
var sum = 10;
for i in 1..<seq.count{
    sum = seq[i-1] == seq[i] ? sum + 5 : sum + 10
}
print(sum)
