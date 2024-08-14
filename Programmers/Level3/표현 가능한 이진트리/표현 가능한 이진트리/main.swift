//
//  main.swift
//  표현 가능한 이진트리
//
//  Created by 양승현 on 8/14/24.
//

import Foundation

/// 문제는 이해했는데
/// 리프노드 탐지 어려웠음....ㅠㅠㅠ
///
/// 특정 테스트케이스 하나 안해줬더니 모든 테케 전부 코어덤프 에러가 떠버림
/// executor(_:) 에 if number==1하니까 성공..
///
/// 리프노드 탐지가 정말 어려웠고... 처음에 이진수 변환할때 계산을 잘못해서 문제 접근이 애매했지만,
/// 계속 예제보니까 리프 노드 제외한 부모 노드가 0이 되는 경우는 안되는 경우임.

/// 어후.... 어렵다

func solution(_ numbers:[Int64]) -> [Int] {
    numbers.map(executor)
}

func executor(_ number: Int64) -> Int {
    var b = String(number, radix: 2).compactMap { Int(String($0)) }
    let pbn = perfectBinaryNodes(from: b.count)
    while b.count != pbn {
        b.insert(0, at: 0)
    }
    /// 와.. 이거 하나 안해줬다고.. 모든 테스트케이스가 core dump뜨는건 ㅠㅠ
    if number == 1 { return 1 }
    return checkSubtree(b)
}

func checkSubtree(_ seq: [Int]) -> Int {
    let s = 0, e = seq.count-1, m = (s+e)/2
    let leftSubtree = Array(seq[s...m])
    let rightSubtree = Array(seq[m+1...e])
    if seq[m] == 0 && (leftSubtree[m/2] == 1 || rightSubtree[m/2] == 1) {
        return 0
    }
    
    if leftSubtree.count >= 3 {
        if checkSubtree(leftSubtree) == 0 {
            return 0
        }
    }
    
    if rightSubtree.count >= 3 {
        if checkSubtree(rightSubtree) == 0 {
            return 0
        }
    }
    
    return 1
}


func perfectBinaryNodes(from nodes: Int) -> Int {
    var perfectBNodes = 1
    while perfectBNodes <= nodes { perfectBNodes <<= 1 }
    return perfectBNodes - 1
}

print(solution([2]))
