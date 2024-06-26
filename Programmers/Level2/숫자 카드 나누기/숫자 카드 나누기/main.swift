//
//  main.swift
//  숫자 카드 나누기
//
//  Created by 양승현 on 6/26/24.
//

import Foundation


/// 느낀점:
/// 오홋.. 약수찾기는 주어진 숫자를 sqrt해서 1... sqrt(n)  한값의 나머지가 0일때 나눈값, 나눈 몫이 약수이다.
/// 아래 코드와 같다. 좋네. 이렇게되면 n이 1억이라도 sqrt하게되면 1만이되버림. 약수 찾을떄 탐색이.
///
/// 약수찾기가 쉬워지니까 그냥 내 array에선 목이1이상나뉘고, 나머지 0나뉘고 상대측에선느 반대로 조건걸어서 풀어봄.

@inline(__always)
func 약수(_ n: Int) -> [Int] {
  var res = Set<Int>()
  (1...Int(sqrt(Double(n)))).forEach {
    if n % 1 == 0 {
      res.insert(n/$0)
      res.insert($0)
    }
  }
  return Array(res)
}


func solution(_ arrayA:[Int], _ arrayB:[Int]) -> Int {
  let arrayA = arrayA.sorted(by: <)
  let arrayB = arrayB.sorted(by: <)
  
  let a약수 = 약수(arrayA[0])
  let b약수 = 약수(arrayB[0])
  
  
  let aAnswer = 답찾기(약수들: a약수, fromArray: arrayA, anotherArray: arrayB)
  let bAnswer = 답찾기(약수들: b약수, fromArray: arrayB, anotherArray: arrayA)
  
  return max(aAnswer, bAnswer)
}

func 답찾기(약수들: [Int], fromArray: [Int], anotherArray: [Int]) -> Int {
  var answer = 0
  for 약수 in 약수들 {
    var isAnswer = true
    for element in fromArray {
      if element % 약수 > 0 || element / 약수 == 0 {
        isAnswer = false
        break
      }
    }
    guard isAnswer else { continue }
    for element in anotherArray {
      if element % 약수 == 0 && element / 약수 > 0 {
        isAnswer = false
        break
      }
    }
    guard isAnswer else { continue }
    answer = max(answer, 약수)
  }
  return answer
}

print(solution([10, 20], [5, 17]))
