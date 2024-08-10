//
//  main.swift
//  수식 최대화
//
//  Created by 양승현 on 8/9/24.
//

import Foundation

/// 처음 풀었을 때는 - 부호 가 맨 앞으로 올 경우에 생각을 못했는데, 지금은 -부호 자체를 하나의 수로 보면서 계산함.
let operators = "*+-".map { String($0) }

func solution(_ expression:String) -> Int64 {
  let priorities = [[0,1,2], [0,2,1],[1,0,2],[1,2,0],[2,0,1],[2,1,0]]
  var ans = 0
  let _tokens = parse(expression: expression)
  priorities.forEach { seq in
    let priority = seq.map { operators[$0] }
    var tokens = _tokens
    priority.forEach { op in
      tokens = reduce(tokens, using: op)
    }
    ans = max(ans, abs(Int(tokens[0]) ?? 0))
  }
  return Int64(ans)
}

func parse(expression: String) -> [String] {
  var operands = expression.components(separatedBy: CharacterSet(charactersIn: "-+*"))
  var idx = 1
  for c in expression {
    guard operators.contains(String(c)) else { continue }
    operands.insert(String(c), at: idx)
    idx+=2
  }
  return operands
}

func reduce(_ parsedExpr: [String], using op: String) -> [String] {
  var tokens = parsedExpr
  while let idx = tokens.firstIndex(of: op) {
    let l = Int(tokens[idx-1]) ?? 0
    let r = Int(tokens[idx+1]) ?? 0
    let res  = execute(op: op, operands: [l, r])
    tokens[idx-1] = String(res)
    tokens.remove(at: idx+1)
    tokens.remove(at: idx)
  }
  return tokens
}

func execute(op: String, operands: [Int]) -> Int {
  ["+": operands[0]+operands[1],
   "-": operands[0]-operands[1],
   "*": operands[0]*operands[1]][op]!
}


print(solution("100-200*300-500+20"))
