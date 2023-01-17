//
//  main.swift
//  [baekjoon]11656
//
//  Created by 양승현 on 2023/01/17.
//

import Foundation

let word: String = readLine()!
print(word.enumerated().map{ word.dropFirst($0.offset)}.sorted(by: <).joined(separator: "\n"))

