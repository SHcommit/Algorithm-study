//
//  main.swift
//  [baekjoon]2231
//
//  Created by 양승현 on 2022/04/30.
//

import Foundation
/**
 * 분해합 : 
 */
var n = Int(readLine()!)!
var result = 1000000

for i in 1..<n {
    
    var temp = i
    var sum = 0
    
    while(temp != 0){
        sum += temp % 10
        temp = temp / 10
        if temp == 0 {
            sum += i
            
            if result > sum  && n == sum {
                result = i
            }
        }
    }
}

print(result == 1000000 ? "0" : "\(result)")
