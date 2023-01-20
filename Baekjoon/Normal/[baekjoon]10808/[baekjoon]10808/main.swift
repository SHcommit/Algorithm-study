//
//  main.swift
//  [baekjoon]10808
//
//  Created by 양승현 on 2023/01/20.
//

import Foundation

var arr = Array(repeating: 0, count: 26)
_=readLine()!.map{Character(String($0))}.map { ch in
    arr[Int(ch.asciiValue!)-97] += 1
}
print(arr.map{String($0)}.joined(separator: " "))
