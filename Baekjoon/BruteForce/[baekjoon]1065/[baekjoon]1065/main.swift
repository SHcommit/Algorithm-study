//
//  main.swift
//  [baekjoon]1065
//
//  Created by 양승현 on 2022/05/02.
//

/**
 * 1부터 입력값까지 주어진 숫자의 자리가 연속일 경우( = 등차수열 )를 구하는 문제
 * 100이하의 수는 모두 한 수
 * 100 이상일 때 각 자리수가 연속일 경우 한 수
 */
import Foundation

solution()

func solution() {
    
    var num = Int(readLine()!)!
    
    print(num<100 ? num : hanSoo(num: num))
}

func hanSoo(num : Int) -> Int{
    var cnt = 0
    for i in 100...num{
        let a = i / 100
        let b = i / 10 % 10
        let c = i % 10
        
        if (a - b) == (b - c) {
            cnt += 1
        }
    }
    return cnt + 99
}
