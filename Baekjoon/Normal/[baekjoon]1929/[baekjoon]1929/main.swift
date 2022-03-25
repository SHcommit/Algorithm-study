//  [baekjoon]1929
//  Created by 양승현 on 2022/03/26.

/**
 * 중첩 포문을 사용해서 2 부터 특정 number까지의 반복으로
 * 문제를 풀었는데 시간초과가 났다.
 *
 * [에라토스테네스의 체](https://commons.wikimedia.org/wiki/File:Sieve_of_Eratosthenes_animation.gif)
 *
 * 에라토스테네스의 체를 사용하면 여러 소수를 보다 빠르게 구할 수 있다.
 *  print() 함수를 매번 출력하는 것보다 string으로 저장후 한번에 출력하는 것이 빨라서 그렇게 했다.
 */
import Foundation

var seq = readLine()!.split(separator: " ").map{Int($0)!}
var prime = Array(repeating: true, count: seq[1]+1)
var res = ""
prime[1] = false

for i in 2..<seq[1] {
    var j = 2
    while i*j <= seq[1]{
        prime[i*j] = false
        j+=1
    }
}
Array( seq[0] ... seq[1]).forEach{
    if prime[$0]  {
        res += "\($0)\n"
    }
}
print(res)
