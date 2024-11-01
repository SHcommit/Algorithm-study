//
//  main.swift
//  Silver4_나는야_포켓몬_마스터_이다솜
//
//  Created by 양승현 on 11/1/24.
//

import Foundation
typealias Element = (name: String, no: Int)
let nr = readLine()!.split{$0==" "}.compactMap { Int($0) }
var nameDict: [Int: String] = [:]
var numDict: [String: Int] = [:]
(1...nr[0]).forEach { i in
  {
    nameDict[i] = $0
    numDict[$0] = i
  }(readLine()!)
}
(0..<nr[1]).forEach { _ in
  var res = readLine()!
  if let typeCasted = Int(res) { res = nameDict[typeCasted]! }
  else { res = String(numDict[res]!) }
  print(res)
}
