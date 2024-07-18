//
//  main.swift
//  로또의 최고 순위와 최저 순위
//
//  Created by 양승현 on 7/19/24.
//

import Foundation

///  let filtered = lottos.filter { $0==0 }
///  내 문제점:
///   왜 틀렸는가를 봤을때 주요 로직들을 자꾸 계속해서 보고, 계산하고 또 봄.
///
///   틀린 이유는 프로그래머스에서 코드 작성할때 let filtered = lottos.filter { $0!=0 }
///   이렇게 0이 아닌 개수를 filter하고, 그것을 기반으로 win_nums.filter에서 각각의 원소에 포함되는지 여부를 파악하는 로직을 작성함.
///   -> 코드 실행하니 틀림 (이유: $0!=0 filter클로저 내부에 이렇게 값 못넣는다고(띄어쓰기 잘못))
///   -> ==로 바꿔야겠다
///   -> 아래 코드들 전부 결과 이상해지는데도 계속 같은. .제자리쳇바퀴러럼함.
///
///  -> 문제도 꼼꼼히봐야하는거 당연한데 코드 하나하나 더 꼼꼼히봐야함..ㅠㅅㅠ
func solution(_ lottos:[Int], _ win_nums:[Int]) -> [Int] {
  let filtered = lottos.filter { $0 != 0 }
  let choice = 6-filtered.count
  let common = win_nums.filter { filtered.contains($0) }
  let good = 7-(common.count+choice)
  let bad = 7-common.count
  return [7 == good ? 6 : good, 7 == bad ? 6 : bad]
}

print(solution([1,2,3,4,5,6], [7,8,9,10,11,23]))
