//
//  main.swift
//  튜플
//
//  Created by 양승현 on 7/27/24.
//

import Foundation

/// trimmingCharacters는 양 끝에서 CharacterSet을 기반으로 제거함.
/// 문제에서의 튜플은. 작은 크기에서의 원소부터, 큰 크기까지 차집합을 통해 하나씩 추가됨.
/// Set<Int>.substracting(Set<Int>)은 {2,1} - {2} 를 하게되면 {1}만 남음. 차집합인것이다 이말이다.
func solution(_ s:String) -> [Int] {
  return s
    .trimmingCharacters(in: CharacterSet(charactersIn: "{}"))
    .components(separatedBy: "},{")
    .map { $0.split(separator:",").compactMap { Int(String($0))}}
    .sorted { $0.count < $1.count }
    .reduce(into: ([Int](), Set<Int>())) {
      let res = Set($1).subtracting($0.0)
      if !res.isEmpty {
        $0.0.append(res.first!)
      }
    }.0
}
print(solution("{{2},{2,1},{2,1,3},{2,1,3,4}}"))

/// 다른 분은 정규 표현식으로 풀었음. . 나도 ..
/// tuplePattern:
///   \{는 escape문자여서 \\{
///   \\d+는 (d: digit-> 0...9의 숫자)가 + (하나 이상) -> 세자리, 다섯자리 이런 숫자를 받겠다!!!!
///   (,\\d+)* -> 그룹화를 한 후에, 쉼표와 1이상의 숫자n까지(9999...)를 콤마를 통해 반복적으로 받겠다.
///   \\} espae문자여서 이렇게 처리!
///   그러니까 " { "로 시작하고 하나 이상의 숫자가 있음 + 쉼표와 반복해서 하나 이상의 숫자가 반복됨 그리고 " } " 로 끝나는 문자열이다!!! 이말인것이다.
///   그럼 이렇게 {2}, {2,1}, {2,1,3} 이게 하나의 매치로 됨
///
/// digitPattern
///   이건 숫자만 패턴화 한것이다.
func sol2(_ s: String) -> [Int] {
  let tuplePattern = "\\{\\d+(,\\d+)*\\}"
  let matchTuples = extractTuple(s, tuplePattern)
  
  let digitPattern = "\\d+"
  var totalTuple: [Int] = []
  
  for tuple in matchTuples {
    let tupleInt = extractTuple(tuple, digitPattern).compactMap { Int(String($0)) }
    for each in tupleInt {
      if !totalTuple.contains(each) { totalTuple.append(each) }
    }
  }
  return totalTuple
}

/// 자!! 이전에는 firstMatch는 첫 매치되는 부분의 문자열만 얻을수 있었는데
/// matches는 패턴에 일치하는 부분 문자열들을 Range(_:in:)을 통해서 바꿀 수 있따.
/// matches 결과로 [NSTextCheckingResult]를 matchString 변수에 저장하는데
/// NSTextCheckingResult를 사용할 때 문자열에서 일치하는 부분만 추출하면 이 객체에서 제공하는 range를 사용한다면 원본 문자열에서 해당 부분을 추출할 수 있다.
///
/// 즉 regex을 통해 matches(in: options: range:)를 사용해 문자열에서 패턴과 일치하는 모든 부분을 찾는다.
/// 이때 NSTextCheckingResult를 반환하는데, 이는 일치하는 부분 문자열 범위를 나타낸다.
/// ```
/// po matchString.map { $0.range }
///   ▿ 4 elements
///     ▿ 0 : {1, 3}
///     - location : 1
///     - length : 3
///     ▿ 1 : {5, 5}
///     - location : 5
///     - length : 5
///     ▿ 2 : {11, 7}
///     - location : 11
///     - length : 7
///     ▿ 3 : {19, 9}
///     - location : 19
///     - length : 9
/// ```
///
// 자. 이걸 보면 "{{2},{2,1},{2,1,3},{2,1,3,4}}" 이 문자열에 대해 matches를 하면
/// "\\{\\d+(,\\d+)\\} 패턴이 일치하는 문자열에 대해 4개의 range를 얻어올수있다. 위에 처럼.
///   1. 1 index 부터 3까지 {2}를 얻어오는것이다. location은 1(index) length는 로케이션부터 3개!!
///   2. 5 index 부터 5개까지 {2,1} 이렇게!!
/// 여기서 일치하는 패턴들만  result로 반환한다는 것이고, 그 일치하는 문자열에서부터 시작해서 일치하는 패턴의 range를 얻을 수 있다.
func extractTuple(_ s: String, _ pattern: String) -> [String] {
  let regex = try? NSRegularExpression(pattern: pattern, options: [])
  guard let matchString = regex?.matches(in: s, options: [], range: NSRange(s.startIndex..., in: s)) else { return [] }
  return matchString.map { String(s[Range($0.range, in: s)!])}
}

print(sol2("{{2},{2,1},{2,1,3},{2,1,3,4}}"))
