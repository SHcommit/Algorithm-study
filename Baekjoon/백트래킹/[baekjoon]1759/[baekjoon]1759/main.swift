//
//  main.swift
//  [baekjoon]1759
//
//  Created by 양승현 on 1/19/24.
//

/*
  좋아. 이제 a 배열에서 x개, b배열에서 y개를 얻어서(조합으로) 수열을 만드는 방법을 알게됨.
  근데 내가 처음 시도했을때 문제는 이렇게하는건 좋았는데 예외처리가 잘 안된다는거였음..
  예를들어 문제에선 최소 한개 모음, 최소 2개 자음을 선택하라했는데 .. 그걸 문제 요약 시점에도 적었었는데
  그런 예외처리를 하지 않는다는거였음. 카카오풀때도 그랬고 예외처리. 특히 문제 지문 안에서의 예외는 반드시 처리해야함.
 */
import Foundation
let nc = readLine()!.split{$0==" "}.map{Int($0)!}
let text = readLine()!.split{$0==" "}.map{String($0)}.sorted()
func recur(from k: Int, withSeq seq: [String]) {
  if seq.count == nc[0] {
    var vCnt = seq.filter{ "aeiou".contains($0) }.count
    if vCnt > 0 && (seq.count-vCnt)>=2 {
      print(seq.joined(separator: ""))
    }
    return
  }
  for i in k..<text.count {
    recur(from:i+1, withSeq: seq + [text[i]])
  }
}
recur(from:0, withSeq: [])
