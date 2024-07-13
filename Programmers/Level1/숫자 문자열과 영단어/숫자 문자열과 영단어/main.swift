//
//  main.swift
//  숫자 문자열과 영단어
//
//  Created by 양승현 on 7/13/24.
//

import Foundation


func solution(_ s:String) -> Int {
  let dict = ["zero":"0", "one":"1", "two":"2", "three":"3", "four":"4",
              "five":"5", "six":"6", "seven":"7", "eight":"8", "nine": "9"]
  let digit = "0123456789".map { String($0) }
  return Int((s+" ").reduce(into: ("",[String]())) { p, n in
    let n = String(n)
    if let a = dict[p.0] {
      p.1.append(a)
      p.0 = ""
    }
    if digit.contains(n) { p.1.append(n) }
    else { p.0 += n }
  }.1.joined())!
}

print(solution("one4seveneight"))
