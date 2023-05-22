//
//  main.swift
//  [baekjoon]1085
//
//  Created by 양승현 on 2023/05/22.
//

import Foundation

let input = readLine()!.split{$0==" "}.map{ Int($0)!}
let x = input[0]
let y = input[1]
let w = input[2]
let h = input[3]

var wx = w - x
var hy = h - y

print([wx,hy,x,y].min()!)
