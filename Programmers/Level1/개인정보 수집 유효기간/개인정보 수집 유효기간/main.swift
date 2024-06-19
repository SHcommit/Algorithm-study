//
//  main.swift
//  개인정보 수집 유효기간
//
//  Created by 양승현 on 6/19/24.
//

import Foundation

/// 잘못한 부분.
/// 여기서 (date.month + termsDuration ) 하지 않고 주어진 추가 기간에 대해서만 %12했다.
/*
func expectedEndDate(_ date: YMDDate, termsDuration: Int) -> YMDDate {
  var month = date.month + termsDuration % 12
  let year = date.year + termsDuration / 12
  let day = date.day - 1 == -1 ? 28 : date.day - 1
  return YMDDate(year: year, month: month, day: day)
}
*/

struct YMDDate {
  let year: Int
  let month: Int
  let day: Int
}

struct Privacy {
  let termsAndConditions: String
  let date: YMDDate
}

extension String {
  func toYMDDate() -> YMDDate {
    let s = self.split{$0=="."}.compactMap { Int(String($0)) }
    return YMDDate(
      year: s[0],
      month: s[1],
      day: s[2])
  }
}

func expectedEndDate(_ date: YMDDate, termsDuration: Int) -> YMDDate {
  var month = (date.month + termsDuration) % 12
  var year = date.year + (date.month + termsDuration) / 12
  if date.day - 1 == 0 {
    month -= 1
  }
  let day = date.day - 1 == 0 ? 28 : date.day - 1
  if month <= 0 {
    year -= 1
    month += 12
  }
  return YMDDate(year: year, month: month, day: day)
}

func isEndOfDate(privacyDate l: YMDDate, currentDate r: YMDDate) -> Bool {
  let privacyDateToDay = l.year * 12 * 28 + l.month*28 + l.day
  let currentDateToDay = r.year * 12 * 28 + r.month*28 + r.day
  
  return privacyDateToDay < currentDateToDay
}

func solution(_ today:String, _ terms:[String], _ privacies:[String]) -> [Int] {
  let terms: [String: Int] = terms
    .map { $0.split{$0==" "} }
    .reduce(into: [String: Int]()) {
      $0[String($1[0])] = Int($1[1])!
    }
  let today: YMDDate = today.toYMDDate()
  let privacies: [Privacy] = privacies.map {
    let packets = $0.split{$0==" "}.map { String($0) }
    return Privacy(termsAndConditions: packets[1], date: packets[0].toYMDDate())
  }
  let expectedEndDateOfPrivacies: [YMDDate] = privacies.map { p in
    let TACDuration = terms[p.termsAndConditions]!
    return expectedEndDate(p.date, termsDuration: TACDuration)
  }
  
  return expectedEndDateOfPrivacies.enumerated().map {
    return ($0 + 1, isEndOfDate(privacyDate: $1, currentDate: today))
  }.filter { $0.1 }
    .map { $0.0 }
}

print(solution("2020.01.01", ["Z 3", "D 5"], ["2019.01.01 D", "2019.11.15 Z", "2019.08.02 D", "2019.07.01 D", "2018.12.28 Z"]))
