import Foundation

/// 와.. 문제를 이렇게.
/// **가장 많이 주문한 단품 메뉴**를 **코스요리 메뉴로** 구성.
/// 이때의 코스 요리는 최소 2가지 + 2명의 손님으로부터 주문된 **단품메뉴 조합**에 대해서만 코스요리 메뉴 후보.
/// 단, 가~장 많이 주문된 메뉴 course.max 의 메뉴 구성이 여러개면, 모두 배열에 담으세요.
///
/// 그래서 2번 예제에서 AB보다 AD가 더 많다! 가장 많이 주문한 제품을 뽑으세요: )
func solution(_ orders: [String], _ course: [Int]) -> [String] {
  var courseCounts: [Int: [String: Int]] = [:]
  
  for order in orders {
    let sortedOrder = order.sorted()
    
    let n = sortedOrder.count
    for courseLength in course {
      if courseLength > n { continue }
      
      var tempCombinations: [[Character]] = []
      makeCombinations(sortedOrder, courseLength, 0, [], &tempCombinations)
      
      for combination in tempCombinations {
        let combStr = String(combination)
        if courseCounts[courseLength] == nil {
          courseCounts[courseLength] = [:]
        }
        if let count = courseCounts[courseLength]?[combStr] {
          courseCounts[courseLength]?[combStr] = count + 1
        } else {
          courseCounts[courseLength]?[combStr] = 1
        }
      }
    }
  }
  
  var answer: [String] = []
  for (length, counts) in courseCounts {
    for (course, count) in counts {
      if count > 1 {
        if let maxCount = counts.values.max(), count == maxCount {
          answer.append(course)
        }
      }
    }
  }
  
  answer.sort()
  
  return answer
}

func makeCombinations(
  _ order: [Character],
  _ length: Int,
  _ start: Int,
  _ current: [Character],
  _ result: inout [[Character]]
) {
  if current.count == length {
    result.append(current)
    return
  }
  
  for i in start..<order.count {
    let char = order[i]
    var newCurrent = current
    newCurrent.append(char)
    makeCombinations(order, length, i + 1, newCurrent, &result)
  }
}
