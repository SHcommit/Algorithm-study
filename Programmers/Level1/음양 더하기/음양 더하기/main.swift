//
//  main.swift
//  음양 더하기
//
//  Created by 양승현 on 7/15/24.
//

import Foundation

func solution(_ absolutes:[Int], _ signs:[Bool]) -> Int {
  zip(absolutes, signs).reduce(0) { $0 + ($1.1 ? $1.0 : -$1.0) }
}
