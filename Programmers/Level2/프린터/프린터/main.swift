//
//  main.swift
//  프린터
//
//  Created by 양승현 on 2023/04/10.
//

import Foundation

// MARK: - Heap
final class Heap<T> where T: Comparable {
  var list: [T] = []
  
  var isLeftSmall: (T,T) -> Bool
  
  init(isLeftSmall: @escaping (T, T) -> Bool) {
    self.isLeftSmall = isLeftSmall
  }
  
}

// MARK: - Helpers
extension Heap {
  var isEmpty: Bool {
    return list.isEmpty
  }
  
  var count: Int {
    return list.count
  }
  
  func insert(_ element: T) {
    var idx = count
    list.append(element)
    while idx>0 && list[(idx-1)/2] < list[idx] {
      list.swapAt((idx-1)/2, idx)
      idx = (idx-1)/2
    }
  }
  
  func delete() -> T? {
    guard isEmpty else {
      return nil
    }
    guard count != 1 else {
      return list.removeFirst()
    }
    var value = list.first!
    var idx = 0
    list.swapAt(count, 0)
    _=list.removeLast()
    
    while idx<count {
      var left = idx * 2  + 1, right = left + 1
      //1. 오른쪽이 클 때
      if right < count {
        if isLeftSmall(list[left], list[right]) && isLeftSmall(list[idx], list[right]) {
          list.swapAt(idx, right)
          idx = right
        }else if isLeftSmall(list[left], list[idx]) {
          list.swapAt(idx, left)
          idx = left
        }
      }else if left < count {
        if isLeftSmall(list[left], list[idx]) {
          list.swapAt(idx, left)
          idx = left
        }
      }
    }
    
    return value
  }
  
}

struct Element {
  let idx: Int
  let priority: Int
}
extension Element: Comparable {
  static func <(lhs: Element, rhs: Element) -> Bool {
    return lhs.priority < rhs.priority
  }
  static func ==(lhs: Element, rhs: Element) -> Bool {
    return lhs.priority == rhs.priority
  }
}


func solution(_ priorities:[Int], _ location:Int) -> Int {
  let priorityQueue = Heap<Element>(isLeftSmall: >)
  let indexs = (0..<priorities.count).map{ $0 }
  let lists = (0..<priorities.count).map{
    Element(idx: indexs[$0], priority: priorities[$0])
  }
  lists.map {
    priorityQueue.insert($0)
  }
  var count = 0
  lists.map {_ in
    guard let value =  priorityQueue.delete() else {
      return
    }
    if value.idx == location {
      print(count)
    }
    count += 1
  }
  return 0
}
