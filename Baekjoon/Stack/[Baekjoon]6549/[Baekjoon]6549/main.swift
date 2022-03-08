//  main.swift
//  [Baekjoon]6549
//  Created by 양승현 on 2022/03/07.

import Foundation

while(true){
    
    var histogram = readLine()!.split(separator: " ").map{Int($0)}
    if histogram[0] == 0{
        break
    }
    var maxValue = histogram[1]!
    var Stack = Array<Int>()
    for i in 0..<histogram[0]!{
        if(histogram[i] == histogram[i+1]){
            maxValue = maxValue + histogram[i]!
            
        }else if histogram[i]! > histogram[i+1]!{
            
        }
    }
    
}
