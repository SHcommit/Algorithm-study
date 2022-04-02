//
//  main.swift
//  [baekjoon]10845
//
//  Created by 양승현 on 2022/04/02.
//

import Foundation

var queue = [String]()

for _ in 0..<Int(readLine()!)! {
    let input = readLine()!.components(separatedBy: " ")

    switch input[0] {
    case "push":
        queue.append(input[1])
    case "pop":
        if queue.isEmpty {
            print(-1)
        } else {
            print(queue[0])
            queue.removeFirst()
        }
    case "size":
        print(queue.count)
    case "empty":
        print(queue.isEmpty ? 1 : 0)
    case "front":
        print(queue.first ?? -1)
    case "back":
        print(queue.last ?? -1)
    default:
        break
    }
}
