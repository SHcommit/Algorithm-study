//
//  main.swift
//  [baekjoon]14500
//
//  Created by 양승현 on 2023/05/10.
//

import Foundation

var hw = readLine()!.map{Int(String($0))!}
let height = hw[0]
let width = hw[1]
let list = (0..<height).map {_ in readLine()!.map { Int(String($0))!}}
