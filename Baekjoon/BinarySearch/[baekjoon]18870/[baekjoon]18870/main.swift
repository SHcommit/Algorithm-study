//
//  main.swift
//  [baekjoon]18870
//
//  Created by 양승현 on 2023/09/26.
//

import Foundation

/*
 
  좌표 압축이 뭘까?
  1 2 3 4 5
 
  4를 압축했다면. 그 압축한 값은 3이어야한다.?
  4이하인 서로 다른 좌표들 개수와 같아야 함.
 
  접근 방식: 결국 특정 좌표보다 큰지 작은지 여부를 파악하는 것이고, x좌표는 1,000,000인데 이중루프를 통해 탐색하면 n^2시간이 걸린다.
  이미 정렬된 배열은 logn 시간복잡도 탐색을 갖는 이진 탐색을 이용했다.
 */

_=readLine()
let xPoints = readLine()!.split{$0==" "}.map{Int(String($0))!}
var seq = Array(Set(xPoints)).sorted()
func binarySearch(_ target: Int) -> String {
  var l=0, r=seq.count, mid = -1
  while l<r {
    mid=(l+r)/2
    if target>seq[mid] {l=mid+1}
    else {r=mid}
  }
  return String(r)
}
print(xPoints.map{binarySearch($0)}.joined(separator: " "))
