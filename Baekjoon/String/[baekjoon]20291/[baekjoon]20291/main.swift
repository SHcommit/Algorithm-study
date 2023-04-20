//
//  main.swift
//  [baekjoon]20291
//
//  Created by 양승현 on 2023/04/18.
//

import Foundation

/*
  중복의 경우 + 무언가를 세는 경우 딕셔너리가 강력하다. 그리고 dropFirst도 좋다.
 */

var lists :[String:Int] = [:]
(0..<Int(readLine()!)!).map{_ in
  let suf = readLine()!.split{$0=="."}.dropFirst().joined()
  guard var _=lists[suf] else { lists[suf] = 1; return }
  lists[suf]! += 1
}
print(lists.sorted{$0.key < $1.key}.map{"\($0.key) \($0.value)"}.joined(separator: "\n"))
