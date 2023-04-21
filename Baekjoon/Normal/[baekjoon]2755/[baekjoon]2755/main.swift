//
//  main.swift
//  [baekjoon]2755
//
//  Created by 양승현 on 2023/04/21.
//

import Foundation

let grade: Dictionary = [
  "A+":4.3, "A0":4.0, "A-":3.7,
  "B+":3.3, "B0":3.0, "B-":2.7,
  "C+":2.3, "C0":2.0, "C-":1.7,
  "D+":1.3, "D0":1.0, "D-":0.7,
  "F":0.0]
let n = Int(readLine()!)!, digit: Double = pow(10, 2)
var credit = 0
print(String(format: "%0.2f",round((0..<n).map{ _ -> Double in
  let input = readLine()!.split{$0==" "}.map{String($0)}
  credit += Int(input[1])!
  return Double(input[1])! * grade[input[2]]!
}.reduce(0,+)/Double(credit)*digit)/digit))
