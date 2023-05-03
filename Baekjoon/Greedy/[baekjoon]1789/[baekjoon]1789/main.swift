//
//  main.swift
//  [baekjoon]1789
//
//  Created by 양승현 on 2023/05/03.
//

import Foundation

// Sol 1
_={
  var i = 1, n = Int(readLine()!)!
  (1..<4294967295).reduce(0){
    i+=1
    if $0+$1>n { print(i-1);exit(0); }
    else if $0+$1==n { print(i); exit(0);}
    return $0+$1
  }
}()

//Sol 2
_={
  var s = Int(readLine()!)!, n = 1
  while n*(n+1)/2<=s { n+=1 }
  print(n-1)
}()
