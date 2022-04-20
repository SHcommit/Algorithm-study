//  [baekjoon]2798
//  Created by 양승현 on 2022/04/21.

import Foundation
//input[0] == N , input[1] == M
var input = readLine()!.split(separator: " ").map{Int(String($0))!}
var arr = readLine()!.split(separator:" ").map{Int(String($0))!}
var result = 0;
for idxI in 0..<arr.count{
    for idxII in idxI + 1..<arr.count{
        for idxIII in idxII + 1..<arr.count{
            // 카드를 3장 골라서 M보다 크지 않거나 같은 3가지 카드의 최대 합을 구합니다.
            let temp = arr[idxI] + arr[idxII] + arr[idxIII]
            if temp <= input[1] && temp > result{
                result = temp;
            }
            
        }
    }
}
print(result);

