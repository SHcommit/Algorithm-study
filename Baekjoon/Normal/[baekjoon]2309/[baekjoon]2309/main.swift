//
//  main.swift
//  [baekjoon]2309
//
//  Created by 양승현 on 2023/02/07.
//

import Foundation

var list = (0..<9).map{_ in Int(readLine()!)! }
let sum = list.reduce(0,+)
_=(0..<8).map{ i in
    _=(i+1..<9).map{ j in
        if sum - list[i] - list[j] == 100 {
            print(list
                .filter{$0 != list[i] && $0 != list[j]}
                .sorted()
                .map{String($0)}
                .joined(separator:"\n"))
            exit(0)
        }
    }
}
