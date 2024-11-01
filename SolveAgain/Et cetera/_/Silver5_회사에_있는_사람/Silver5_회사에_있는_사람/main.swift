//
//  main.swift
//  Silver5_회사에_있는_사람
//
//  Created by 양승현 on 11/1/24.
//

import Foundation

print(
  (0..<Int(readLine()!)!)
    .reduce(into: [String: String](), { dic, _ in { dic[$0[0]] = $0[1] }(readLine()!.split{$0==" "}.map{String($0)}) })
    .filter { $1 == "enter" }
    .map { $0.key }
    .sorted(by: >)
    .joined(separator: "\n"))
