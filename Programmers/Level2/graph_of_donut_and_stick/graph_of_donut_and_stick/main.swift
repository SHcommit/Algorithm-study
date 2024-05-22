//
//  main.swift
//  graph_of_donut_and_stick
//
//  Created by 양승현 on 5/22/24.
//

import Foundation

func solution(_ inputEdges:[[Int]]) -> [Int] {
  typealias NodeFlow = (input: Int, output: Int)
  var answer = (0..<4).map { _ in 0 }
  
  var nodes = inputEdges.flatMap { $0 }.max()!
  
  var nodeFlows: [NodeFlow] = Array(repeating: (0,0), count: nodes)
  
  inputEdges.forEach { edge in
    let start = edge[0] - 1
    let end = edge[1] - 1
    nodeFlows[end] = (nodeFlows[end].input+1, nodeFlows[end].output)
    nodeFlows[start] = (nodeFlows[start].input, nodeFlows[start].output+1)
  }
  
  answer[0] = nodeFlows
    .enumerated()
    .filter {
      if $0.element.output >= 2 && $0.element.input == 0 { return true }
      return false
    }.first
    .map { $0.offset }! + 1
  
  for (index, nodeFlow) in nodeFlows.enumerated() {
    if index == answer[0] - 1 { continue }
    if nodeFlow.input >= 2 && nodeFlow.output >= 2 {
      answer[3] += 1
    } else if nodeFlow.input >= 1, nodeFlow.output == 0 {
      answer[2] += 1
    }
  }
  
  let irrelevantNodeOutputs = nodeFlows[answer[0]-1].output
  answer[1] = irrelevantNodeOutputs - (answer[2] + answer[3])
  
  /// 생성한 정점의 번호, 도넛모양 그래프 수, 막대모양 그래프 수, 8자모양 그래프 수
  return answer
}

print(solution([[4, 11], [1, 12], [8, 3], [12, 7], [4, 2], [7, 11], [4, 8], [9, 6], [10, 11], [6, 10], [3, 5], [11, 1], [5, 3], [11, 9], [3, 8]]))
