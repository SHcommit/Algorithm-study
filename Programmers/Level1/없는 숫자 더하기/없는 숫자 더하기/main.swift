//
//  main.swift
//  없는 숫자 더하기
//
//  Created by 양승현 on 7/6/24.
//

import Foundation

func solution(_ n:[Int]) -> Int {
  (0...9).filter{!n.contains($0)}.reduce(0,+)
}

print(solution([5,8,4,0,6,7,9]))
