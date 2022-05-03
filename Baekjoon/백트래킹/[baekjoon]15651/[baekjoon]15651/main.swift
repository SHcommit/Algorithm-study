//
//  main.swift
//  [baekjoon]15651
//
//  Created by 양승현 on 2022/05/03.
//

import Foundation

var input = readLine()!.split(separator: " ").map{Int(String($0))!}

for i in 1...input[0]{
    var res = ""
    var k = 1
    for j in 0..<input[1]{
        while(k != input[0]){
            res += "\(j) "
            k += 1
        }
        
    }
    print(res)
}
