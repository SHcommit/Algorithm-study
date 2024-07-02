//
//  main.swift
//  택배상자
//
//  Created by 양승현 on 7/2/24.
//

import Foundation


// MARK: - 1트 시간초과. sCV 더하기 때문에 초과가 더 심하게 난듯함돠.

//func solution(_ order:[Int]) -> Int {
//  var order = order.reversed().map { $0-1 }
//  var sCV: [Int] = []
//  var cv = stride(from: order.count-1,through:0, by:-1).map { $0 }
//  var res = 0
//  while let product = order.popLast() {
//    if let last = cv.last, last <= product, let cvIdx = cv.firstIndex(of: product) {
//      // 여기서 시간 잡아무
//      sCV.append(contentsOf: cv[cvIdx+1..<cv.count].reversed())
//      cv.removeLast(cv.count-cvIdx)
//      res += 1
//    } else if let sCVProduct = sCV.popLast(), sCVProduct == product {
//      res += 1
//    } else {
//      break
//    }
//  }
//  return res
//}

// MARK: - i 루프 안에 하도록 변경해서 append 할때 O(1)씩 되도록 수정.
func solution(_ order:[Int]) -> Int {
  let cnt = order.count
  var order: [Int] = order.map { $0-1 }.reversed()
  var stack: [Int] = []
  var res = 0
  var i = 0
  while i < cnt {
    if let product = order.last {
      if product == i {
        res+=1
        _=order.removeLast()
        i+=1
      } else if product > i {
        stack.append(i)
        i+=1
      } else {
        _=order.removeLast()
        if let sProduct = stack.popLast(), sProduct == product {
          res += 1
        } else {
          break
        }
      }
    } else {
      break
    }
  }
  while !order.isEmpty, let sProduct = stack.popLast() {
    if sProduct == order.removeLast() {
      res += 1
    }
  }
  
  return res
}


print(solution([4 ]))
