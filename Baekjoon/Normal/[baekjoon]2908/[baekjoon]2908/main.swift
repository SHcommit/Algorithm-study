//
//  main.swift
//  [baekjoon]2908
//
//  Created by 양승현 on 2023/05/06.
//

import Foundation
print(readLine()!.split{$0==" "}.map{String($0.reversed())}.max()!)
