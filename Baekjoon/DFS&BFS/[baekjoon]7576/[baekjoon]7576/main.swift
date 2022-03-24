//  [baekjoon]7576
//  Created by 양승현 on 2022/03/21.

import Foundation

var MN = readLine()!.split(separator: " ").map{Int(String($0))!}

var graph = Array(repeating: Array(repeating: 0, count: MN[0]), count: MN[1])

