//
//  main.swift
//  [baekjoon]12605
//
//  Created by 양승현 on 2023/03/13.
//

import Foundation

(1...Int(readLine()!)!).map{
    print("Case #\($0): \(readLine()!.split{$0==" "}.reversed().joined(separator: " "))")
}
