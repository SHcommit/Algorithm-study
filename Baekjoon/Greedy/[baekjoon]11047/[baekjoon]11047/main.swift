//  main.swift
//  [baekjoon]11047
//  Created by 양승현 on 2022/04/01.

import Foundation

var NK = readLine()!.split(separator: " ").map{Int($0)!}
var count = 0;
var money = [Int]()
var k = NK[1]
for _ in 0..<NK[0]{
    money.append(Int(readLine()!)!)
}
 
 money =  Array(money.reversed())
 for i in money{
 count += k/i
 k %= i
 }
for i in stride(from: NK[0] - 1 , to: 0, by: -1) {
    count += k / money[i];
    k = k % money[i];
    if k ==  0 {
        break;
    }
}
print(count)
