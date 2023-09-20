//
//  main.swift
//  [baekjoon]16968
//
//  Created by 양승현 on 2023/09/20.
//

import Foundation

/**
 문제 요약:
 - 차량 번호판 형식이 주어진다. 가능한 차량 번호판의 개수 구하기.
 - 가능한 숫자: 0...9 == d
 - 가능한 문자: a...z == c
 - 번호판 형식 최대 4글자. cd로 이루어진 문자열로 나타낼 수 있음.
 - c는 문자 위치 자리, d는 숫자 위치 자리.
 - 같은 문자나 숫자가 연속 2번 나타나면 안됨.
 */

let input = readLine()!.map { String($0) }
let dict = ["c":26, "d":10]
var prev = input[0]
print(input.enumerated().map {
  if prev == $1 && $0 != 0 { return dict[$1]! - 1 }
  prev = $1
  return dict[$1]!
}.reduce(1, *))

