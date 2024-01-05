//
//  main.swift
//  [baekjoon]1107
//
//  Created by 양승현 on 2023/09/22.
//

import Foundation

/**
  문제 요약:
  버튼 너무 세게 눌러 일부 숫자 버튼 고장.
 
  [리모컨]
  - 버튼 0...9
  - +, -
 
  + 누를 경우 지금 보는 체널 + 1. - 누르면 -1 이동.
  체널 0에서 -로 누르면 체널 변함x 근데 체널은 무한대.
  
  
  지금 이동하려는 체널은 N.
  특정 버튼이 고장났을 때 N으로 이동하기 위해 최소 눌러야 하는 버튼!!
 
 수빈이 100번 보고 있음.
 
 */

let target = Int(readLine()!)!
_=readLine()
let bugNumbers = readLine()!.split { $0 == " " }.map { Int(String($0))! }
let normalNumbers = (0...9).filter { !bugNumbers.contains($0) }
var res = abs(target - 100)

