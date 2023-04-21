//
//  main.swift
//  [baekjoon]6550
//
//  Created by 양승현 on 2023/04/21.
//

//https://dev-with-precious-dreams.tistory.com/221

import Foundation

while let input = readLine() {
  let temp = input.split{$0==" "}.map{String($0)}
  let (text, needle) = (temp[1].map{String($0)},temp[0].map{String($0)})
  var tIdx = 0, nIdx = 0
  while tIdx < text.count && nIdx < needle.count {
    if text[tIdx] == needle[nIdx] { nIdx += 1 }
    tIdx+=1
  }
  print(nIdx == needle.count ? "Yes" : "No")
}
