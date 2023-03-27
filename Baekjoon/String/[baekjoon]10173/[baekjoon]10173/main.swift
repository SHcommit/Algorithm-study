//
//  main.swift
//  [baekjoon]10173
//
//  Created by 양승현 on 2023/03/27.
//

import Foundation

while let text = readLine() {
  if text == "EOI" { break }
  print(text.lowercased().contains("nemo") ? "Found" : "Missing")
}
