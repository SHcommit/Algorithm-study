//
//  main.swift
//  없는 숫자 더하기
//
//  Created by 양승현 on 7/6/24.
//

import Foundation

func solution(_ numbers:[Int]) -> Int {
  "0123456789".map{Int(String($0))!}.filter{!(numbers.contains($0))}.reduce(0,+)
}

print(solution([5,8,4,0,6,7,9]))
