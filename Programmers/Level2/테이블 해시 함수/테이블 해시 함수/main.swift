//
//  main.swift
//  테이블 해시 함수
//
//  Created by 양승현 on 6/26/24.
//

import Foundation

func solution(_ data:[[Int]], _ col:Int, _ row_begin:Int, _ row_end:Int) -> Int {
  let s_i = data.sorted { $0[col-1] == $1[col-1] ? $0[0] > $1[0] : $0[col-1] < $1[col-1] }
    .enumerated()
    .map { n, sData in return sData.reduce(0) { return $0 + ($1 % (n+1)) } }
  return (row_begin-1..<row_end).reduce(0) { $0^(s_i[$1]) }
}

print(solution([[2,2,6],[1,5,10],[4,2,9],[3,8,3]], 2, 2, 3))
