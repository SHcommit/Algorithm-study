//
//  main.swift
//  [baekjoon]20546
//
//  Created by 양승현 on 1/5/24.
//

import Foundation

let c = Int(readLine()!)!, 일봉차트 = readLine()!.split{$0==" "}.map{Int(String($0))!}
var junStock = 0, sungStock = 0, 총알 = c, 등락 = 0, 
_=일봉차트.map {
  junStock+=총알/$0
  총알%=$0
}
junStock = junStock * 일봉차트.last! + 총알
총알 = c
_=일봉차트.enumerated().map {
  if $0 - 1 < 0 { return }
  if $1 < 일봉차트[$0-1] {
    등락 = 등락 > 0 ? -1 : 등락 - 1
    if 등락 <= -3 {
      sungStock+=총알/$1
      총알%=$1
    }
  } else if $1 > 일봉차트[$0-1] {
    등락 = 등락 < 0 ? 1 : 등락 + 1
    if 등락 >= 3  {
      총알+=sungStock * $1
      sungStock=0
    }
  } else { 등락 = 0 }
}
sungStock = sungStock * 일봉차트.last! + 총알
print(junStock > sungStock ? "BNP" : junStock == sungStock ? "SAMESAME" : "TIMING")
