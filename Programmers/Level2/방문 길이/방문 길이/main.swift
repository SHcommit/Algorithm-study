//
//  main.swift
//  방문 길이
//
//  Created by 양승현 on 7/21/24.
//

import Foundation

/// input값은 상당히 작았음으로 시간곱잡도는 크게 고려 x.
/// 간선 정보를 저장하는 방법은 또 처음 접하는것 같았음. 좌표 저장을 보통하는 문제를 만났었기에..
///
/// 한번 방문한 간선 정보는 딕셔너리에 출발노드: Set<도착 노드>
/// 이렇게 지정하고, S -> D로 갈 때, D -> S로 가는 딕셔너리에도 동일하게 추가했다.
/// 이떄 보면.. Destination node를 보면 딕셔너리에 default값을 지정하고 추가로 또 insert했다. 불필요한 삽입이 한번씩 발생하긴 하는데,
/// if else 구문을 안쓰고자 이렇게 했다.
///
/// ```
/// if dict[np] == nil {
///   dict[np] = Set([tempCp])
/// } else {
///   dict[np]?.insert(tempCp)
/// }
/// ```
///
/// 이 구문은
/// dict[np, default: Set([tempCp]).insert(tempCp)
///
/// 이거로 대체가 가능한데, 이유는 Set을 사용했기 때문.
struct Point: Hashable {
  let x:Int, y:Int
  init(_ x: Int,_ y: Int) { self.x = x; self.y = y }
}
func solution(_ input:String) -> Int {
  let direct: [String: Point] = ["U": .init(0,1), "L": .init(-1,0), "R": .init(1,0), "D": .init(0,-1)]
  var dict = [Point: Set<Point>]()
  var cp: Point = .init(0,0)
  return input.filter {
    let dPoint: Point = direct[String($0)]!
    let np: Point = .init(cp.x+dPoint.x, cp.y+dPoint.y)
    let tempCp = cp
    if !((-5...5)~=np.x && (-5...5)~=np.y) { return false }
    cp = np
    if let fromD = dict[tempCp] {
      if fromD.contains(np) {
        dict[np, default: Set([tempCp])].insert(tempCp)
        return false
      }
      dict[tempCp]?.insert(np)
      dict[np, default: Set([tempCp])].insert(tempCp)
    } else {
      dict[tempCp] = Set([np])
      dict[np, default: Set([tempCp])].insert(tempCp)
    }
    return true
  }.count
}
print(solution("UUUUUUDDDDDDDUUUU"))
