//
//  main.swift
//  [baekjoon]1264
//
//  Created by 양승현 on 2023/07/04.
//

import Foundation

while let input = readLine(), input != "#" {
  print(input.lowercased().filter{"aeiou".map{String($0)}.contains(String($0))}.count)
}
