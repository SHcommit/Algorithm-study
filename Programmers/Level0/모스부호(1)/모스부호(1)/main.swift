//
//  main.swift
//  모스부호(1)
//
//  Created by 양승현 on 6/24/24.
//

import Foundation
let morse = ".-:a,-...:b,-.-.:c,-..:d,.:e,..-.:f,--.:g,....:h,..:i,.---:j,-.-:k,.-..:l,--:m,-.:n,---:o,.--.:p,--.-:q,.-.:r,...:s,-:t,..-:u,...-:v,.--:w,-..-:x,-.--:y,--..:z"
func solution(_ letter:String) -> String {
  let dict = morse.split{$0==","}.map { String($0) }.reduce(into: [String: String]()) { d, str in
    let splited = str.split{$0==":"}.map { String($0) }
    d[splited[0]] = splited[1]
  }
  return letter.split { $0==" " }.compactMap { dict[String($0)] }.joined(separator: "")
}

print(solution(".--. -.-- - .... --- -."))
