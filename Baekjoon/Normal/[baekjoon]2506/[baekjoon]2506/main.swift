//  main.swift
//  [baekjoon]2506
//  Created by 양승현 on 2022/03/15.
import Foundation
var sum = 0
var seq = 0
var n = Int(readLine()!)!
var array = readLine()!.split(separator: " ").map{Int($0)!}
for i in 0..<array.count{
    array[i] == 0 ? seq = 0 : {seq += 1; sum += seq}()
}
print("\(sum)")
