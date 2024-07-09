//
//  main.swift
//  부족한 금액 계산하기
//
//  Created by 양승현 on 7/9/24.
//

import Foundation

func solution(_ price:Int, _ money:Int, _ count:Int) -> Int64{
  { $0 > 0 ? Int64(0) : Int64(abs($0)) }(money - (1...count).reduce(0) {$0 + $1*price})
}

print(solution(3, 20, 4))
