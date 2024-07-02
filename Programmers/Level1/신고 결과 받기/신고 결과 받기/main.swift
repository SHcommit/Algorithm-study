//
//  main.swift
//  신고 결과 받기
//
//  Created by 양승현 on 7/2/24.
//

import Foundation

/// 30분만에 풀었는데 딱 한곳에서 시간초과.
///
/// 첫 시도는 아래와 같이했다. 근데 시간초과가 날만하긴하다.. contains도 O(n)그리고 블라끄 유저도 O(n)
///  (사용자는 천명이라서).
///   이때 O(n^2)가 최악의 경우 예상될수있었기에,
///
///   좀 더 수월하게 그냥 투포인터? 느낌으로 둘다 소팅한 후에, 접근해나가서 O(n^2)보다 단축.
///
/// ```
/// for i id in id_list.enumerated() {
///   guard var reportIdList = reportIds[id] else { continue }
///   for blockedUser in blockedUsers {
///     if !(reportIdList.contains(blockedUser)) {
///       res[i]+=1
///     }
///   }
/// }
/// ```
///
/// 다른사람들의 코드를보며 개선해보자!
func solution(_ id_list:[String], _ reports:[String], _ k:Int) -> [Int] {
  var reportsUserReceived = id_list.reduce(into: [String: Int]()) { $0[$1] = 0 }
  var reportIds = id_list.reduce(into: [String: [String]]()) { $0[$1] = [String]() }
  for report in reports {
    let fromTo = report.split{$0==" "}.map { String($0) }
    if reportIds[fromTo[0]]!.contains(fromTo[1]) { continue }
    reportIds[fromTo[0]]?.append(fromTo[1])
    reportsUserReceived[fromTo[1]]! += 1
  }
  var res = (0..<id_list.count).map {_ in 0 }
  var blockedUsers: [String] = []
  for id in id_list {
    let reportCount = reportsUserReceived[id] ?? 0
    if reportCount >= k { blockedUsers.append(id) }
  }
  blockedUsers.sort()
  for (i, id) in id_list.enumerated() {
    guard var reportIdList = reportIds[id] else { continue }
    reportIdList.sort()
    var blockedUserIdx = 0
    var reportedIdIdx = 0
    while reportedIdIdx < reportIdList.count && blockedUserIdx < blockedUsers.count {
      let reportedId = reportIdList[reportedIdIdx]
      let blockedUser = blockedUsers[blockedUserIdx]
      if reportedId == blockedUser {
        res[i]+=1
        blockedUserIdx += 1
        reportedIdIdx += 1
      } else if reportedId > blockedUser {
        blockedUserIdx += 1
      } else {
        reportedIdIdx += 1
      }
    }
    
  }
  return res
}
