//
//  main.swift
//  명예의 전당(1)
//
//  Created by 양승현 on 6/26/24.
//

import Foundation

/// 이번에는 bs 생각도 할겸.. lis느낌으로 다가 풀어봤다.
/// 그냥 score탐색할 때마다 res를 매번 소팅해도 되는데,  O(n^2)가 될껄?
/// 이분탐색으로 순서는 매번 정렬된거니까 내가 한 방법은 O(n*logN) 이다. 인가? 일거야!
func solution(_ k:Int, _ score:[Int]) -> [Int] {
  var arr: [Int] = [score[0]]
  var res: [Int] = [score[0]]
  score[1..<score.count].forEach {
    let idx = binarySearch(arr, target: $0)
    arr.insert($0 ,at: idx)
    if k < arr.count {
      _=arr.removeFirst()
    }
    res.append(arr[0])
  }
  return res
}

func binarySearch(_ arr: [Int], target: Int) -> Int {
  var l = 0, r = arr.count, mid = 0
  while l < r {
    mid = (l+r)/2
    if target > arr[mid] { l = mid+1 }
    else { r = mid }
  }
  return l
}
print(solution(3, [10,100,20,150,1,100,200]))
