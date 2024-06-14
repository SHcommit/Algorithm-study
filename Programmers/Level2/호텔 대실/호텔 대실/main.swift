//
//  main.swift
//  호텔 대실
//
//  Created by 양승현 on 6/14/24.
//

import Foundation

//typealias Element = (s: Int, e: Int)
//func solution(_ book_time:[[String]]) -> Int {
//  var currentUsingTime: [Element] = []
//  var mostUsedRoomInSpecTime: Int = 0
//  let booking: [Element] = book_time.map {
//    let s = toMin(from: $0[0])
//    let e = toMin(from: $0[1])
//    return (s,e+10)
//  }.sorted { $0.s < $1.s }
//  
//  booking.forEach {
//    if currentUsingTime.isEmpty {
//      currentUsingTime.append($0)
//      mostUsedRoomInSpecTime = max(currentUsingTime.count, mostUsedRoomInSpecTime)
//    } else {
//      var idx = 0
//      var isNeededNewRoom = false
//      while idx < currentUsingTime.count {
//        let usingTime = currentUsingTime[idx]
//        if usingTime.s >= $0.s || usingTime.e > $0.s {
//          isNeededNewRoom = true
//        } else if usingTime.e <= $0.s {
//          currentUsingTime.remove(at: idx)
//          currentUsingTime.append($0)
//          isNeededNewRoom = false
//          break
//        }
//        idx += 1
//      }
//      if isNeededNewRoom {
//        currentUsingTime.append($0)
//        mostUsedRoomInSpecTime = max(currentUsingTime.count, mostUsedRoomInSpecTime)
//      }
//    }
//  }
//  
//  return mostUsedRoomInSpecTime
//}
//
//@inline(__always)
//func toMin(from h_m: String) -> Int {
//  let hm = h_m.split{$0==":"}.map {Int($0)!}
//  return hm[0]*60 + hm[1]
//}


// MARK: - 최대한 빨리 푸는데 초점을 맞췄고 중복 로직을 추리면..
typealias Element = (s: Int, e: Int)
func solution(_ book_time:[[String]]) -> Int {
  var currentUsingTime: [Element] = []
  var mostUsedRoomInSpecTime: Int = 0
  let booking: [Element] = book_time.map {
    let s = toMin(from: $0[0])
    let e = toMin(from: $0[1])
    return (s,e+10)
  }.sorted { $0.s < $1.s }
  
  booking.forEach {
    var idx = 0
    var isNeededNewRoom = true
    while idx < currentUsingTime.count {
      let usingTime = currentUsingTime[idx]
      if usingTime.e <= $0.s {
        currentUsingTime.remove(at: idx)
        currentUsingTime.append($0)
        isNeededNewRoom = false
        break
      }
      idx += 1
    }
    if isNeededNewRoom {
      currentUsingTime.append($0)
      mostUsedRoomInSpecTime = max(currentUsingTime.count, mostUsedRoomInSpecTime)
    }
  }
  return mostUsedRoomInSpecTime
}

@inline(__always)
func toMin(from h_m: String) -> Int {
  let hm = h_m.split{$0==":"}.map {Int($0)!}
  return hm[0]*60 + hm[1]
}

