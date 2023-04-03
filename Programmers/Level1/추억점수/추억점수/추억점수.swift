//
//  main.swift
//  추억점수
//
//  Created by 양승현 on 2023/04/03.
//

import Foundation

func solution( _ name:[String], _ yearning:[Int], _ photo:[[String]]) -> [Int] {
  let costs = Dictionary(uniqueKeysWithValues: zip(name, yearning))
  return photo.map{ $0.reduce(0) { $0+(costs[$1] ?? 0) }}
}
