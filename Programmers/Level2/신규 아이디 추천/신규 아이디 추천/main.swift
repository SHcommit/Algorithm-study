//
//  main.swift
//  신규 아이디 추천
//
//  Created by 양승현 on 7/19/24.
//

import Foundation

/// 이야 정규식 대단하다잉..
///
/// 1. [a-z0-9-._] 가 아닌 문자열  ( 특수문자 제거 )
/// 2. 점이 [.] 최소 두개 이상 {2,} 일때
/// 3. 문자열 맨 앞에 점이 있을 경우 ^[.]
/// 4. 문자열 맨 뒤에 점이 있을 경우 [.]$
///
/// 이렇게 정규식을 통해서 검증했을때 일치하지 않는 문자열들은
///   - NSRegularExpression.stringByReplacingMatches(in:range:withTemplate:)로 다른 template로 변환이 가능하다.
func solution(_ i:String) -> String {
  var new_id = i.lowercased()
  ["[^a-z0-9-_.]", "[.]{2,}", "^[.]", "[.]$"].enumerated().forEach { i, pattern in
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    let range = NSRange(location: 0, length: new_id.count)
    var template = ""
    if i == 1 { template = "." }
    new_id = regex.stringByReplacingMatches(in: new_id, range: range, withTemplate: template)
  }
  
  if new_id.isEmpty {
    new_id = "a"
  } else if new_id.count >= 16 {
    new_id = String(new_id.prefix(15))
    if new_id.last == "." {
      new_id.removeLast()
    }
  }
  if new_id.count <= 2 {
    let lastId = new_id.last!
    while new_id.count < 3 {
      new_id.append(lastId)
    }
  }
  return new_id
}

print(solution("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"))
