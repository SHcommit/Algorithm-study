//
//  main.swift
//  두 큐 합 같게 만들기
//
//  Created by 양승현 on 7/5/24.
//

import Foundation

// MARK: - 1st try
// 시간 초과 뜸. 이유는... reversed()자체는 O(1)이라는 거 알고있엇음 reverse()는 O(n)이구..
// 근데 결국에 reversed()를 할당받은 변수는 cow로 참조카운트가 올라가 O(1)이지만, 이게 값을 변경하는 순간 값복사가 일어나서 O(N)이되버림.
// 결국 dequeue작업이 O(n)임ㅋ.

/// 2nd try
///
/// 이때는 Queue를 구현할때 내부적으로 두개를 사용.
/// 좋은거같아. dequeue보다 enqueue가 많아져서 원소들이 많아지고, 내부적으로 output queue가 없을때 reversed()를해주는데 이건 O(1)
/// 그리고 팝 처음할때는 O(n)인데, 그 이후로는 dequeue의 element가 비기 전까지는 O(1)로 popLast를 수행.
/// 어쩌다가 이제 dequeue가 빌때만 O(n)임. 부분적 o(n) 그래서 이를 활용했다.
///
@inline(__always)
func dequeue(_ queue: inout [(Int, Int)]) -> (Int, Int)? {
  queue = queue.reversed()
  let t = queue.popLast()
  queue.reverse()
  return t
}

@inline(__always)
func insert(_ queue: inout [(Int, Int)], element: (Int, Int)) {
  queue.append(element)
}

func solution1(_ queue1:[Int], _ queue2:[Int]) -> Int {
  let queue1Count = queue1.count, queue2Count = queue2.count
  var q1 = queue1.enumerated().map { ($0.offset, $0.element) }
  var q2 = queue2.enumerated().map { ($0.offset, $0.element) }
  var numOfPoppedQ1LastElement = 0, numOfPoppedQ2LastElement = 0
  var res = 0
  var sumOfQ1 = queue1.reduce(0,+), sumOfQ2 = queue2.reduce(0,+)
  var minValue = abs(sumOfQ1-sumOfQ2)
  if minValue % 2 == 1 { return -1 }
  if minValue == 0 { return res }
  minValue/=2
  let targetValue = sumOfQ1 < sumOfQ2 ? sumOfQ1+minValue : sumOfQ1 - minValue
  while numOfPoppedQ1LastElement < 2 && numOfPoppedQ2LastElement < 2 {
    if sumOfQ1 == targetValue {
      return res
    }
    if sumOfQ1 > targetValue {
      guard let element = dequeue(&q1) else { return -1 }
      if element.0 == queue1Count-1 { numOfPoppedQ1LastElement += 1 }
      sumOfQ1 -= element.1
      insert(&q2, element: element)
      sumOfQ2 += element.1
      res += 1
    } else {
      guard let element = dequeue(&q2) else { return -1 }
      if element.0 == queue2Count-1 { numOfPoppedQ2LastElement += 1 }
      sumOfQ2 -= element.1
      insert(&q1, element: element)
      sumOfQ1 += element.1
      res += 1
    }
  }
  return -1
}

print(solution1([1,4], [4,8]))

// MARK: - 2nd try

final class Queue<E> {
  private var inset: [E] = []
  private var outset: [E] = []
  init(inset: [E]) { self.inset = inset }
  var count: Int { inset.count + outset.count }
  
  func insert(_ value: E) {
    inset.append(value)
  }
  
  func dequeue() -> E? {
    if outset.isEmpty {
      outset = inset.reversed()
      inset.removeAll(keepingCapacity: true)
    }
    return outset.popLast()
  }
}

func solution(_ queue1:[Int], _ queue2:[Int]) -> Int {
  let queue1Count = queue1.count, queue2Count = queue2.count
  var q1 = Queue(inset: queue1.enumerated().map { ($0.offset, $0.element) })
  var q2 = Queue(inset: queue2.enumerated().map { ($0.offset, $0.element) })
  var numOfPoppedQ1LastElement = 0, numOfPoppedQ2LastElement = 0
  var res = 0
  var sumOfQ1 = queue1.reduce(0,+), sumOfQ2 = queue2.reduce(0,+)
  var minValue = abs(sumOfQ1-sumOfQ2)
  if minValue % 2 == 1 { return -1 }
  if minValue == 0 { return res }
  minValue/=2
  let targetValue = sumOfQ1 < sumOfQ2 ? sumOfQ1+minValue : sumOfQ1 - minValue
  while numOfPoppedQ1LastElement < 2 && numOfPoppedQ2LastElement < 2 {
    if sumOfQ1 == targetValue {
      return res
    }
    if sumOfQ1 > targetValue {
      guard let element = q1.dequeue() else { return -1 }
      if element.0 == queue1Count-1 { numOfPoppedQ1LastElement += 1 }
      sumOfQ1 -= element.1
      q2.insert(element)
      sumOfQ2 += element.1
      res += 1
    } else {
      guard let element = q2.dequeue() else { return -1 }
      if element.0 == queue2Count-1 { numOfPoppedQ2LastElement += 1 }
      sumOfQ2 -= element.1
      q1.insert(element)
      sumOfQ1 += element.1
      res += 1
    }
  }
  return -1
}

print(solution([1,1], [1,5]))
