//
//  main.swift
//  [baekjoon]13706
//
//  Created by 양승현 on 2022/05/08.
//


import Foundation
/**
 * 이거 .. 알고리즘은 맞는데 스위프트는 안됌,, ㅇ??
 *
 * * 이진 탐색!! *
 * 원하는 데이터 = k
 * 정렬된 데이터들의 가운데 = m
 * ---
 * 원하는 데이터를 찾을 때 까지 정렬된 데이터들의 가운데를 기준으로 크면 그 오른쪽 list 탐색
 *      else 왼쪽 list 탐색하는 방법입니다!
 */

var number = Int(readLine()!)!

squareRoot()

func squareRoot(){
    var start = 1
    var end = number
    var mid : Int
    if number == 0 {
        print(0)
        return
    }
    while (true){
        mid = (start + end) / 2
        if (mid * mid) == number{
            print(mid)
            return
        }else if mid * mid > number{
            end = mid
        }else if mid * mid < number{
            start = mid
        }
    }
}
