//
//  main.swift
//  [baekjoon]3066
//
//  Created by 양승현 on 2023/02/22.
//

import Foundation

func bs(_ seq: inout [Int], target: Int) {
    var l=0,r=seq.count-1,m=0
    defer{seq[r]=target}
    while l<r {
        m=(l+r)/2
        if target>seq[m] { l=m+1 }
        else { r=m }
    }
}

var res=""
(0..<Int(readLine()!)!).map{_ in
    let lists = (0..<Int(readLine()!)!)
        .map{_ in Int(readLine()!)!}
    var seq = [lists.first!]
    (1..<lists.count).map{
        if lists[$0]>seq.last! {
            seq.append(lists[$0])
        }else {
            bs(&seq, target: lists[$0])
        }
    }
    res += "\(seq.count)\n"
}
print(res)
