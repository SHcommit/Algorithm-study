//
//  main.swift
//  [baekjoon]1302
//
//  Created by 양승현 on 2023/04/23.
//

import Foundation
//https://dev-with-precious-dreams.tistory.com/manage/posts/
var list: [String:Int] = [:]
_=(0..<Int(readLine()!)!).map{ _ in list[readLine()!, default: 0] += 1 }
print(list.max { return $0.value==$1.value ? $0.key>$1.key : $0.value<$1.value }!.key)



