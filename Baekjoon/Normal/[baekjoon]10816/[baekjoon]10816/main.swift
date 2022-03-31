//  main.swift
//  [baekjoon]10816
//  Created by 양승현 on 2022/03/31.

import Foundation

var N = Int(readLine()!)!
var SGsCard = readLine()!.split(separator: " ").map{Int(String($0))!}
var M = Int(readLine()!)!
var givenNum = readLine()!.split(separator: " ").map{Int(String($0))!}
var dic = [Int:Int]()
var res = ""

for i in SGsCard.sorted() {
    dic[i] = dic.keys.contains(i) ? dic[i]! + 1 : 1
}
for i in givenNum {
    if dic.keys.contains(i){
        res += "\(dic[i]!) "
    }else{
        res += "\(0) "
    }
}
print(res)
