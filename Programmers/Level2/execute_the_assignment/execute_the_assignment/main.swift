//
//  main.swift
//  execute_the_assignment
//
//  Created by 양승현 on 5/31/24.
//


import Foundation


/// 과제는 시작 시간이 존재.
/// 새로운 과제 시작 시간이 됐을때 기존 과제를 진행중이라면, 그 과제 멈추고 새로운 과제 시작.

/// 진행중인 과제 끝낸후, 위에서 도중에 멈춘 과제가 있다면 멈춰둔 과제 이어서 진행
/// 이때 새로 시작해야하는 과제가 있다면 해당 과제부터 시작.

/// 우선순위: 새로 시작해야할 과제 -> 진행중인 과제

/// 모든 과제의 시작시간은 다르다.과제가 끝나는시각 -> 새로운 과제 시작시각이 같ㄷ면 진행중인 과제는 끝난것으로 판단.

/// 이 조건을 못봄. 미뤄진과제가 여러개 있다면 최근에 멈춘 과제부터.

typealias Name = String
typealias Duration = [Int]
typealias TaskEntity = (Name: Name, Duration: Duration)
func solution(_ inputPlans:[[String]]) -> [String] {
  let StartIdx = 0, TimeIdx = 1
  let plans: [TaskEntity] = inputPlans.map { inputPlan in
    let hm = inputPlan[1].split{ $0 == ":" }.map { Int($0)! }
    return (inputPlan[0], [hm[0]*60 + hm[1], Int(inputPlan[2])!])
  }.sorted { $0.Duration[0] < $1.Duration[0] }
  var result: [Name] = []
  var suspendedTasks: [TaskEntity] = []
  var task: TaskEntity = plans[0]
  
  for plan in plans[1..<inputPlans.count] {
    let restTime = task.Duration[StartIdx] + task.Duration[TimeIdx] - plan.Duration[StartIdx]

    /// 제 시간내 다 못끝냈다?
    if restTime > 0 {
      suspendedTasks.append((task.Name, [task.Duration[StartIdx], restTime]))
    } else {
      /// plan 다 끝낼경우.
      result.append(task.Name)
      
      /// 남은 시간에 밀렸던 과제 진행.
      /// 밀린 과제 진행중 지정된 나머지 시간 다쓰면 다시 넣기.
      var absRestTime = abs(restTime)
      while absRestTime > 0 {
        /// 여기서 break를 안해서 suspendedTask 가 없어서 계속 무한 루프 돌았던 음. 이런것도 조건처리 확실하게 해줘야함.
        guard let latestSuspendedTask = suspendedTasks.last else {
          break
        }
        let timeSpend = latestSuspendedTask.Duration[TimeIdx] - absRestTime
        if timeSpend <= 0 {
          result.append(latestSuspendedTask.Name)
          _=suspendedTasks.removeLast()
          absRestTime = abs(timeSpend)
        } else {
          /// 아하.. 여기서 timeSpend를 뺐는데, absRestTime을 뺏어야했다. 빼니까 맞았다!!
          suspendedTasks[suspendedTasks.count-1].Duration[TimeIdx] -= absRestTime
          break
        }
      }
    }
    task = plan
  }
  result.append(task.Name)
  
  /// 과제 끝낸 순서대로 이름을 담아 반환
  for i in stride(from: suspendedTasks.count-1, through: 0, by: -1) {
    result.append(suspendedTasks[i].Name)
  }
  return result
}

print(solution([["aaa", "12:01", "10"], ["bbb", "12:02", "9"], ["ccc", "12:03", "7"], ["ddd", "12:10", "10"]]))
