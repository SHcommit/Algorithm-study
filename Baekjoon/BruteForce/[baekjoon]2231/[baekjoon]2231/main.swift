//
//  main.swift
//  [baekjoon]2231
//
//  Created by 양승현 on 2022/04/30.
//

import Foundation
/**
 * 문제 : https://www.acmicpc.net/problem/2231
 * ----------------------------------------
 * 입력값 = n
 *
 * 분해합 = n + n의 각 자리수
 * 이때의 n을 M이라하고, 생성자라고 한다.
 *      즉, 분해합 = m + n의 각 자리수.
 *
 *  포문을 통해 1부터 입력값까지 브루트포스 탐색을 실시한다.
 *      variable 클래스는 for문에 쓰일 변수
 *      - temp(이 변수에서 각 자리수를 얻어낼 것임),
 *      - sum(각 자리수를 더한 결과)
 *      을 저장합니다.
 *  i 를 특정 생성자라고 가정하고, 생성자 + 이 생성자의 각 자리수의 합 == 입력값일 때
 *  이전에 구한 값보다 작으면 결과가 되는 것!
 * ----------------------------------------
 * 주의할 점
 * 생성자 (M ) 존재하지 않을 경우 0을 반환 해야한다.
 */


solution()

func solution(){
    
    let n = inputN()
    var result = 1000000
    
    bruteForce(number: n, result: &result)
    
    print(result == 1000000 ? "0" : "\(result)")
}

class variable{
    var temp : Int
    var sum : Int
    
    init(M temp : Int){
        sum = 0
        self.temp = temp
    }
}


func bruteForce(number n : Int, result: inout Int ){
    
    for i in 1..<n {
        let data = variable(M: i)
        
        while(data.temp != 0){
            data.sum += data.temp % 10
            data.temp = data.temp / 10
            
            if data.temp == 0 {
                data.sum += i
                if result > data.sum  && n == data.sum {
                    result = i
                }
            }
        }
    }
}

func inputN()-> Int{
    if let n = readLine() {
        return Int(n) ?? 0
    }
    return 0
}
