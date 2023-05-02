//
//  main.swift
//  [baekjoon]5635
//
//  Created by 양승현 on 2023/05/02.
//

import Foundation
let a = (0..<Int(readLine()!)!)
  .map{ _ -> (String,Int,Int,Int) in
    let s = readLine()!.split{$0==" "}.map{String($0)}
    return (s[0],Int(s[1])!,Int(s[2])!,Int(s[3])!)
  }
  .sorted {
    if $0.3 == $1.3 {
      if $0.2 == $1.2 { return $0.1 < $1.1 }
      else { return $0.2 < $1.2 }
    } else { return $0.3 < $1.3 }
  }
print("\(a.last!.0)\n\(a.first!.0)")
