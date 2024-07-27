//
//  main.swift
//  14906-스러피
//
//  Created by 양승현 on 7/27/24.
//


/// 안돼.ㅔ[[ㅔ[[
import Foundation
/// 부분 문자로 나눌때는 중가 문자는 ^가들아간다면, 당연히 부분으로 분리할 경우에만 해야함.
let slumpPattern = "^[DE]F+([DE]F+)*G$"
let prefixPattern = "^A.*[HC]"
let suffixPattern = "[DE].*G$"

func isSlump(_ string: String, pattern: String = slumpPattern) -> Bool {
  !extract(string, pattern: pattern).isEmpty
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
      let wonder = input[2..<input.count].map{$0}
      if input[1] == "B" {
        //슬림프
        return isSlimp(wonder)
      }else {
        // 스럼프
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
