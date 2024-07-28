//
//  main.swift
//  오픈채팅방
//
//  Created by 양승현 on 7/28/24.
//

import Foundation

typealias UID = String
typealias Name = String

func solution(_ record:[String]) -> [String] {
  let splittedRecord = record.map { r in
    r.split{$0==" "}.map { String($0) }
  }
  
  let room: [UID: Name] = splittedRecord.reduce(into: [UID: Name]()) { p, n in
    let uid = n[1], state = n[0]
    if p[uid] == nil || state == "Enter" || state == "Change" {
      p[uid] = n[2]
    }
  }
  return splittedRecord
    .compactMap {
      let uid = $0[1], name = room[uid] ?? "", state = $0[0]
      switch state {
      case "Enter":
        return "\(name)님이 들어왔습니다."
      case "Leave":
        return "\(name)님이 나갔습니다."
      default:
        return nil
      }
    }
}
print(solution(["Enter uid1234 Muzi", "Enter uid4567 Prodo","Leave uid1234","Enter uid1234 Prodo","Change uid4567 Ryan"]))
