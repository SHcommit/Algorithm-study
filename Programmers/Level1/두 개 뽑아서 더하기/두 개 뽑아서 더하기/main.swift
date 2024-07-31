//
//  main.swift
//  두 개 뽑아서 더하기
//
//  Created by 양승현 on 8/1/24.
//

import Foundation

func solution(_ numbers:[Int]) -> [Int] {
  Set((0..<numbers.count-1).map { i -> [Int] in
    (i+1..<numbers.count).map { j -> Int in numbers[i] + numbers[j]  }
  }.flatMap{$0}).sorted()
}

print(solution([5,0,2,7]))
