//
//  main.swift
//  주차-요금-계산
//
//  Created by 양승현 on 2023/05/02.
//

import Foundation

struct Fee {
  var defaultTime: Int
  var defaultTimeMoney: Int
  var unitTime: Int
  var unitTimeMoney: Int
}

struct CarInfo {
  var time: Int
  var number: String
  var parkedState: String
}
func solution(_ fees:[Int], _ records:[String]) -> [Int] {
  let fee = Fee(
    defaultTime: fees[0],
    defaultTimeMoney: fees[1],
    unitTime: fees[2],
    unitTimeMoney: fees[3])
  var carNumbers: [String] = []
  
  var parkingInfo: [CarInfo] = records.map{
    let input = $0.split{$0==" "}.map{String($0)}
    let hm = input[0].split{$0==":"}.map{Int(String($0))!}
    if !carNumbers.contains(where: {$0==input[1]}) {
      carNumbers.append(input[1])
    }
    return CarInfo(
      time: hm[0]*60 + hm[1],
      number: input[1],
      parkedState: input[2])
  }
  
  carNumbers.sort()
  
  return carNumbers.map { carNum in
    let parkedInfos = parkingInfo.filter{ $0.number == carNum }
    var isLastCalculate = false
    if parkedInfos.count % 2 == 1 {
      isLastCalculate = true
    }
    var prevInfo: CarInfo = CarInfo(time: 0, number: "", parkedState: "")
    var time = 0
    for (i,carState) in parkedInfos.enumerated() {
      if i == parkedInfos.count-1 && isLastCalculate { break }
      if i % 2 == 0 {
        prevInfo = carState
      }else {
        time += carState.time - prevInfo.time
      }
    }
    
    if isLastCalculate {
      time += 23*60 + 59 - parkedInfos.last!.time
    }
    
    if time - fee.defaultTime < 0 {
      return fee.defaultTimeMoney
    }else {
      time = time - fee.defaultTime
      if time % fee.unitTime > 0 {
        time = (time / fee.unitTime) + 1
      }else {
        time = time/fee.unitTime
      }
      return fee.defaultTimeMoney + time*fee.unitTimeMoney
    }
    
  }
  
}
