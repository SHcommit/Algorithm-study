//
//  main.swift
//  문자열 압축
//
//  Created by 양승현 on 8/10/24.
//

import Foundation

/// ㅁㅅㅁ
///
/// 그리디하게 + s.count / 2까지만 해서 압축할 문자열 개수만큼 stride로 반복하면서,
/// comparer가 비어있다면 값지정, comparer와 같으면 개수증가, comparer와 다를 경우 ans에 증가 후 comparer 수정.
///
///
/// 여기서 가장 주의할 것은 마지막 압축할 문자열 비교 경우인데,
/// - stride활용한 포문 안에서 comparer와 같지 않을 경우, 이전까지비교했던 경우를 ans에 반영하고 comparer를 새로운 값으로 치환한다.
/// - 그리고 포문이 끝나버리면 이 새로 치환된것 도 추가해주어야만 된다.
func solution(_ s: String) -> Int {
  let ss = s.map { String($0) }
  var ansCnt = s.count
  if s.count == 1 { return s.count }
  for limit in 1...(s.count / 2) {
    var comparer = ""
    var count = 0
    var ans = ""
    
    for i in stride(from: 0, to: ss.count, by: limit) {
      let end = min(i + limit, ss.count)
      let seq = ss[i..<end].joined()
      
      if comparer == "" {
        comparer = seq
        count = 1
      } else if comparer == seq {
        count += 1
      } else {
        ans += count == 1 ? comparer : "\(count)\(comparer)"
        comparer = seq
        count = 1
      }
    }
    ans += count == 1 ? comparer : "\(count)\(comparer)"
    ansCnt = min(ansCnt, ans.count)
  }
  return ansCnt
}
