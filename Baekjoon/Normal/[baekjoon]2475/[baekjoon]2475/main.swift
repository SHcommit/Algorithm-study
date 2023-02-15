//
//  main.swift
//  [baekjoon]2475
//
//  Created by 양승현 on 2023/02/15.
//

import Foundation

print(readLine()!
    .split{$0==" "}
    .map{Int($0)! * Int($0)!}
    .reduce(0,+)
    .map{$0/10}
    .first!)
