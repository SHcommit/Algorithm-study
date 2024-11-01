//
//  main.swift
//  Silver4_비밀번호_찾기
//
//  Created by 양승현 on 11/1/24.
//

import Foundation

print({ input -> String in
  let idPwDic = (0..<input[0]).reduce(into: [String: String]()) { dic, _ in
    let idPw = readLine()!.split{$0==" "}.map { String($0) }
    dic[idPw[0]] = idPw[1]
  }
  return (0..<input[1]).map { _ in
    idPwDic[readLine()!] ?? ""
  }.joined(separator: "\n")
}(readLine()!.split{$0==" "}.compactMap { Int($0)} ))
