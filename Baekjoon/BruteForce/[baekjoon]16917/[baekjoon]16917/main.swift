//
//  main.swift
//  [baekjoon]16917
//
//  Created by 양승현 on 2023/09/20.
//

import Foundation

/**
  치킨 종류: 양념, 후라이드, 반반 치킨.
         A원     B원          C원

 양념 최소 X, 후라 최소 y마리 구매.  이떄 반반을 통해 하나의 양념, 후라이드 만들 수 있음.
 
  abcxy
 
 느낀점;
 와 대박.. 대박임.
 최소 x마리, 최소 y마리 구매 비용이라는 문구가있고, 반반으로 특정 값 이상 구매해도 x한마리 구매비용보다 작다면 작은것....으미 대박
 */
let input = readLine()!.split{$0==" "}.map { Int(String($0))! }
let (a,b,c,d,e) = (input[0],input[1],input[2],input[3],input[4])
let shared = min(d,e), last = abs(d-e)
var res = c*shared*2
res += min(d>e ? a*last : b*last, c*last*2)
print(min(res, a*d + b*e))
