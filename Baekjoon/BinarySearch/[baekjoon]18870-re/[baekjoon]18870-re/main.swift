//
//  main.swift
//  [baekjoon]18870-re
//
//  Created by 양승현 on 9/4/24.
//

import Foundation

/// 이거는 내가 떙기는대로 풀어봤구..
func task1() {
  _=readLine()
  let seq = readLine()!.split{$0==" "}.compactMap { Int(String($0)) }
  let dict = Array(Set(seq)).sorted(by: <).enumerated().reduce(into: [Int: Int]()) { p, n in
    p[n.element] = n.offset
  }
  print(seq.map{String(dict[$0] ?? 0)}.joined(separator: " "))

}
// task1()

/// 이거는 이분탐색으로 풀어보쟈
///
/// 입력값의 범위는 10^9임 엄청큼. 크기순으로 번호를 매기려고 할 때 이게 좌표 압축!
/// 1. 리스트 정렬
/// 2. 중복 제거
/// 3. 이제 중복제거됬고 정렬된 배열들을 가지구 이분탐색을 호출해서 해당 위치의 인덱스를 반환하면 됨! 뾈!
func task2() {
  _=readLine()
  let raw = readLine()!.split{$0==" "}.compactMap{Int(String($0))}
  let seq = Array(Set(raw)).sorted(by: <)
  
  func bs(_ t : Int) -> String {
    var l = 0, r = seq.count-1, m = 0
    while (l<=r) {
      m = (l+r)/2
      if seq[m] > t {
        r = m - 1
      } else if seq[m] < t {
        l = m + 1
      } else {
        return String(m)
      }
    }
    fatalError()
  }
  
  print(raw.map(bs).joined(separator: " "))
  
}
task2()
