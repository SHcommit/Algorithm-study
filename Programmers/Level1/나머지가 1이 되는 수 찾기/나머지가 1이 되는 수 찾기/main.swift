//
//  main.swift
//  나머지가 1이 되는 수 찾기
//
//  Created by 양승현 on 7/4/24.
//

import Foundation

func solution(_ n:Int) -> Int {
  for i in 2..<n where n % i == 1 { return i }
  exit(0)
}
