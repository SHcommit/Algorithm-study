//  [baekjoon]1032
//  Created by 양승현 on 2022/03/26.

/**
 * 입력예제의 첫번째 배열을 기준으로
 * 이후 입력받는 배열의 각 index Value가 같은지를 비교 후
 * 다르다면 첫번째 배열 value를 ? 로 바꿔준다.
 */
import Foundation

var n = Int(readLine()!)!
var res = Array(readLine()!).map{String($0)}
for _ in 0..<n - 1 {
    let nextStr = Array(readLine()!).map{String($0)}
    for i in 0..<nextStr.count {
        if res[i] != nextStr[i]  {
            res[i] = "?"
       }
    }
}
print(res.joined())

