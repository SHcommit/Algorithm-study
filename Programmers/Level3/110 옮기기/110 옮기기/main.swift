//
//  main.swift
//  110 옮기기
//
//  Created by 양승현 on 9/12/24.
//

import Foundation

/// https://dev-with-precious-dreams.tistory.com/297
///
/// 뭔가 풀면서 110을 옮기는 최적의 방법은 110을 발견시 앞에 111... or 11 or 1이 존재한다면 그 앞에, 뒤에 0이 존재한다면 그 뒤에삽입하는게 좋다고생각했다.
/// 이미 처리한 곳에 또 다시 연산을 수행하지 않도록 하는게 까다로웠다.
/// 다른 분들은 110을 전부 추출했다.
/// 110을 전부 추출하지 않아도 연산을 수행하다보니 110이 연이어 위치한다는걸 알게됬다..
///
/// String.Index를 사용하는 것보다 문자열도 배열로 만들어서 삽입, 삭제 연산을 수행하는게 좀 시간초과가 나지 않는다는 것을 알게됨.
let solution: ([String]) -> [String] = { $0.map(minimize) }
func minimize(_ s: String) -> String {
  var ooz: [String] = [], notOptimized: [String] = []
  for c in s {
    notOptimized.append(String(c))
    if notOptimized.count >= 3 && notOptimized.suffix(3).elementsEqual(["1","1","0"]) {
      notOptimized.removeLast(3)
      "110".forEach { ooz.append(String($0))}
    }
  }
  
  if let zeroIdx = notOptimized.lastIndex(of: "0") {
    notOptimized.insert(contentsOf: ooz, at: zeroIdx+1)
    return notOptimized.joined()
  } else {
    return (ooz + notOptimized).joined()
  }
}
print(solution(["1110","100111100","0111111010"]))
