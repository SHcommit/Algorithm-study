//
//  main.swift
//  [baekjoon]11501
//
//  Created by 양승현 on 2023/01/19.
//

_=(0..<Int(readLine()!)!).map{_ in
    _=Int(readLine()!)!
    let arr = readLine()!.split{$0==" "}.map{Int(String($0))!}
    var total = 0
    var max = arr.last!
    _=arr.reversed().map {
        if $0 >= max {
            max = $0
        } else {
            total += (max-$0)
        }
    }
    print(total)
}
