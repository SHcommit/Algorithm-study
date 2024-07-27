//
//  main.swift
//  3진법 뒤집기
//
//  Created by 양승현 on 7/27/24.
//

import Foundation

/// 10진법을 n진법으로 바꾸려면 String(_:radix:)를 사용했었다.
///
/// 이번엔 반대로 n진법을 10진법으로 바꾸어야 할 땐, Int(_:radix:)를 사용해야 한다.
func solution(_ n:Int)->Int{Int(String(String(n,radix:3).reversed()),radix:3)!}
