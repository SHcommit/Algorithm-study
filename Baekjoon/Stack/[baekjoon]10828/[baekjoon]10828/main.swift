//
//  main.swift
//  [baekjoon]10828
//
//  Created by 양승현 on 2022/03/24.
//

import Foundation

var n = Int(readLine()!)!
var stack = [String]()
var res = ""
for _ in 0..<n {
    var command = readLine()!.split(separator: " ").map{String($0)}
    switch command[0]{
    case "push":
        stack.append(command.last!)
    case "pop":
        let pop = stack.popLast() ?? "-1\n"
        res += pop+"\n"
    case "top":
        let top  = stack.last ?? "-1\n"
        res += top+"\n"
    case "empty":
        res = stack.isEmpty ? res + "1\n" : res + "0\n"
    case "size":
        res += "\(stack.count)\n"
    default:
        break;
    }
}

print(res)
