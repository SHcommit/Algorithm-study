//
//  main.swift
//  표 편집
//
//  Created by 양승현 on 9/10/24.
//

import Foundation

/// 어떻게 삭제한 정보를 다시 가져올 수 있을까?
/// -> 스택을 이용하자.
///
/// 어떻게 삭제하지 않은 노드끼리만 탐색할 수 있을까? 연결리스트를 이용하자.
///
/// 어떻게 삭제한 데이터, 삭제하지 않은 데이터들을 기억할 수 있을까?
/// -> 배열을 이용하자...
///
/// 배열을 이용해 원본 데이터의 삭제여부도 표시함과 더불어,
///   원소들의 prev, next를 통해 삭제된 정보를 반영해주고, current node를 통해서 이동할 수 있다.

final class Node {
  var prev: Node?
  var next: Node?
  var isDeleted: Bool = false
}
func solution(_ n:Int, _ k:Int, _ cmd:[String]) -> String {
  var nodes = (0..<n).map { _ in Node() }
  var removedBuf: [Node] = []
  var curNode = nodes[k]
  for i in 1..<n {
    nodes[i-1].next = nodes[i]
    nodes[i].prev = nodes[i-1]
  }
  for command in cmd {
    let splitted = command.split{$0==" "}.map { String($0) }
    switch splitted[0] {
    case "U":
      let x = Int(splitted[1])!
      for _ in 0..<x {
        guard let prev = curNode.prev else { break }
        curNode = prev
      }
    case "D":
      let x = Int(splitted[1])!
      for _ in 0..<x {
        guard let next = curNode.next else { break }
        curNode = next
      }
    case "C":
      curNode.isDeleted = true
      removedBuf.append(curNode)
      curNode.prev?.next = curNode.next
      curNode.next?.prev = curNode.prev
      curNode = curNode.next ?? curNode.prev!
    default:
      let popped = removedBuf.popLast()
      popped?.isDeleted = false
      popped?.next?.prev = popped
      popped?.prev?.next = popped
    }
  }
  return nodes.map { $0.isDeleted ? "X" : "O" }.joined()
}
print(solution(8, 2, ["D 2", "C", "U 3", "C", "D 4", "C", "U 2", "Z", "Z"]))
