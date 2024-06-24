//
//  main.swift
//  유사 칸토어 비트열
//
//  Created by 양승현 on 6/24/24.
//

import Foundation

/// 으앗... 분할 정보그!!..
///
/// 로직은 이게 0, 1 제외한 2부터 계속해서 n-1의 비트열 4개가 반복되는 형식이다.
/// 어차피 가운데는 0인데 문제에서는 1을 구하는거여서 1에 초점을 둬야한다.
/// 분할정복드로다가. 실질적으로 l에 해당하는 5개의 비트 -> 1개 각각으로 divide한 후에, 그 왼쪽, 오른쪽 범위가 -1 차이가 나지 않는다면 포함하는 범위로 간주하고 값을 증가.
/// 왼쪽은 max로 하는 이유는 , 최소 left보다 크다면 다 포함인거고,
/// 이걸 제어하는게 오른쪽 min..이다.
///
/// 어렵당
func solution(_ n:Int, _ l:Int64, _ r:Int64) -> Int {
  return div(n: Int(pow(5.0, Double(n))), l: Int(l-1), r: Int(r-1))
}

func div(n: Int, l: Int, r: Int) -> Int {
  if l > r { return 0 }
  if n == 1 { return 1 }
  let n = n/5
  return (0..<5).reduce(0) { sum, i in
    if i == 2 { return sum }
    return sum + div(n: n, l: max(n*i, l) - i*n, r: min(n*(i+1)-1, r) - i*n)
  }
}

print(solution(2, 1, 4))
