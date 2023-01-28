//
//  main.swift
//  [baekjoon]2675
//
//  Created by 양승현 on 2023/01/28.
//

import Foundation

_=(0..<Int(readLine()!)!).map{_ in
    let input = readLine()!.split{$0==" "}.map{String($0)}
    let text = input[1].map{String($0)}
    _=text.map{ char in
        print(String(repeating: char, count: Int(input[0])!), terminator: "")
    }
    print()
}
