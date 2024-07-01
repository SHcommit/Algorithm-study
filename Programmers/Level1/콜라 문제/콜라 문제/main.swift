//
//  main.swift
//  콜라 문제
//
//  Created by 양승현 on 7/1/24.
//

import Foundation

func solution(_ a:Int, _ b:Int, _ n:Int) -> Int {
  var receivedCoke = n
  var emptyCoke = 0
  var res = 0
  while true {
    var tempReceivedCoke = (receivedCoke + emptyCoke)/a*b
    var tempEmptyCoke = (receivedCoke + emptyCoke)%a
    receivedCoke = tempReceivedCoke
    emptyCoke = tempEmptyCoke
    res += receivedCoke
    if (receivedCoke + emptyCoke) < a { return res }
  }
}

// 코드 개선.
func solution2(_ a:Int, _ b:Int, _ n:Int) -> Int {
  var receivedCoke = n
  var res = 0
  while receivedCoke >= a {
    res += (receivedCoke) / a * b
    receivedCoke = receivedCoke/a*b + receivedCoke % a
  }
  return res
}
