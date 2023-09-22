//
//  main.swift
//  [baekjoon]14659
//
//  Created by 양승현 on 2023/09/22.
//

/**
 오버워치를 한판 해봤기에 한조 캐릭터 이름은 알고 있었음. lis로 풀까 생각했지만.. 브론즈라 참았다...
 */

import Foundation

_=readLine()
var list = readLine()!.split{$0==" "}.map{Int(String($0))!}
var target = 0, cnt = 0
print(list.map {
  cnt += 1
  if target < $0 { cnt = 0; target = $0 }
  return cnt
}.max() ?? 0)
