//
//  main.swift
//  대충만든자판
//
//  Created by 양승현 on 6/12/24.
//

import Foundation

/// [ 문제 설명 ]
///
/// 휴대폰의 자판은 하나의 키에 여러 문자가 할당될 수 있다.
/// -> 키를 연속해서 빠르게 누를 경우 할당된 순서대로 문제 변경된다.
///
/// e.g. 1번키 "A", "B", "C" 할당됬을떄 1번키 한번, A. 2번 B 3번 C.
///
/// 키의 개수가 1~100까지일 수 있다.. 특정 키 눌렀을 때 입력되는 문자도 문작위로 배열되어 있다.
/// 같은 문자가 지판 전체에 여러 번 할당된 경우도 있다. 키 하나에 같은 문자 여러 번 할당된 경우도 잇다. 아예 할당 안된것도 있음.
///
/// 키를 최소 몇번 눌러야 해당 문자열을 작성할 수 있는지 알아보자. 작성 x할때 -1 반환
func solution(_ keymap:[String], _ targets:[String]) -> [Int] {
  let keymapDict: [String: Int] = keymap.reduce(into: [String:Int]()) { dict, aKeymap in
    aKeymap.map { String($0) }.enumerated().forEach { i, c in
      dict[c] = min(dict[c] ?? Int.max, i+1)
    }
  }
  return targets.map { target in
    var isAvailableMessage = true
    var sum = 0
    for c in target {
      guard let v = keymapDict[String(c)] else {
        isAvailableMessage.toggle()
        break
      }
      sum += v
    }
    return isAvailableMessage ? sum : -1
  }
}

print(solution(["AGZ", "BSSS"] ,   ["ASA","BGZ"] ))
