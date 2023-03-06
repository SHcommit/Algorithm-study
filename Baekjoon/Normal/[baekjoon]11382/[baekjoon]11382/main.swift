//
//  main.swift
//  [baekjoon]11382
//
//  Created by 양승현 on 2023/03/06.
//

import Foundation

print(readLine()!.split{$0==" "}.map{Int($0)!}.reduce(0,+))
