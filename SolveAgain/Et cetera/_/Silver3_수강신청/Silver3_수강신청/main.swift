//
//  main.swift
//  Silver3_수강신청
//
//  Created by 양승현 on 11/1/24.
//

import Foundation

let input = readLine()!.split{$0==" "}.compactMap { Int($0) }
let rawArray = (0..<input[1]).map { _ in readLine()! }
var dict = rawArray.reduce(into: [String: Int]()) { dic, e in dic[e, default: 0] += 1 }
var res: [String] = []
rawArray.forEach {
  if dict[$0, default: 0] == 1 && res.count != input[0] { res.append($0) }
  else { dict[$0] = dict[$0]! - 1 }
}
print(res.joined(separator: "\n"))
