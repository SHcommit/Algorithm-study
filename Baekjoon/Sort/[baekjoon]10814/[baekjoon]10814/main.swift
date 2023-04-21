//
//  main.swift
//  [baekjoon]10814
//
//  Created by 양승현 on 2023/04/20.
//

import Foundation

print((0..<Int(readLine()!)!).map{_ ->(String,String) in let a=readLine()!.split{$0==" "}.map{String($0)};return (a[0], a[1])}.sorted{Int($0.0)!<Int($1.0)!}.map{"\($0.0) \($0.1)"}.joined(separator: "\n"))
