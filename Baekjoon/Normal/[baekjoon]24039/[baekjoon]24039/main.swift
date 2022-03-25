//  [baekjoon]24039
//  Created by 양승현 on 2022/03/26.

import Foundation
/**
 * 소수 구하는 방법 ex ) 주어진 수가 30이라면
 * for (i = 2; i< 30 ; i++ ){
 *   if (30 % i ) == 0
 *      break;
 * }
 * //30이 2~30 미만의 수로 나누어진다면 소수가 아님을 이용해 문제를 풀었습니다.
 */
var year = Int(readLine()!)!

var prime = [2]
var i = 0

for num in 2..<10001{
    for j in 2..<num {
        if num % j == 0 {
            break
        }
        if num == j + 1 {
            prime.append(num)
        }
    }
}
for i in 1..<prime.count{
    if prime[i] * prime[i-1] > year {
        print(prime[i]*prime[i-1])
        break;
    }
}

