//
//  main.swift
//  14906-스러피
//
//  Created by 양승현 on 7/27/24.
//


/// 이번 문제를 틀렸던 이유는
/// isSlimp를 검사할때 B인지 아닌지에 따라서, AB + ... + C  or A + ... + C 이렇게 비교해야하는거였는데,
///   이 시점에서 난 inner string을 추출하는 let wonder를 되도록 적게 사용하고자 맨 위에 선언했었음.. "B"가 두번째 위치에 있는지 여부에 따라 검사는 하지만, 결국
///   동일한 로직을 실행했던것임.ㅋㅋ,,,. 너무 코드를 줄일려고 하다보니 또 이렇게 예기치 못한.. 분기처리까지 했는데 결국 분기처리 한 이유가 없는 코드를 만들었던 것이다.
///
/// ---
/// 로직은 일단 slump의 경우엔 정규식으로 처리 가능한데, 재귀는 정규식으로 하기 살짝 껄끄러움. 어려움 아직(안되는것 같기도하구..)
///
/// -> 1. slimp 와 slump 구간을 분리한다. 이때!!!!! slimp의 pattern을 활용해 범위를 구하고, 그 범위 끝부터, 문자열 마지막 개수까지 의 범위를 새로 하면 prefix, suffix이렇게
///   분리가 정규화 패턴으로 가능하다는것임!!!!
///
///   나머지 slimp는 문제 조건에 따라 재귀를 썻고, 이때 맞는지 여부만 판단하기 위해 재귀의 끝? 조건 지검까지 탐구하면서 bool값을 거기서 반환하도록 설계함.
///
/// 어머.. Swift로 도전한 사람이 없다..

import Foundation
/// 부분 문자로 나눌때는 중가 문자는 ^가들아간다면, 당연히 부분으로 분리할 경우에만 해야함.
let slumpPattern = "^[DE]F+([DE]F+)*G$"
let prefixPattern = "^A.*[HC]"
let suffixPattern = "[DE].*G$"

func isSlump(_ string: String) -> Bool {
  extract(string, pattern: slumpPattern).first?.isEmpty == false
}

func extract(_ s: String, pattern: String) -> [String] {
  let regex = try? NSRegularExpression(pattern: pattern, options: [])
  guard let match = regex?.firstMatch(in: s, range: NSRange(s.startIndex..., in: s)) else {
    return []
  }
  let otherRange = NSRange(location: match.range.length, length: s.count-match.range.length)
  return [String(s[Range(match.range, in: s)!]), String(s[Range(otherRange, in: s)!])]
}


func isSlimp(_ input: [Character]) -> Bool {
  if input.first == "A" {
    if input.count == 2, input.last == "H" {
      return true
    }
    if input.count >= 4, input.last == "C" {
      if input[1] == "B" {
        //슬림프
        let wonder = input[2..<input.count-1].map{$0}
        return isSlimp(wonder)
      }else {
        // 스럼프
        let wonder = input[1..<input.count-1].map{$0}
        return isSlump(wonder.map {String($0)}.joined())
      }
    }
  }
  return false
}

print("SLURPYS OUTPUT")
print((0..<Int(readLine()!)!).map { _ in
  let splitted = extract(readLine()!, pattern: prefixPattern)
  guard splitted.count == 2 else { return "NO" }
  if isSlimp(splitted[0].map { $0 }) && isSlump(splitted[1]) {
    return "YES"
  }
  return "NO"
}.joined(separator: "\n"))
print("END OF OUTPUT")
