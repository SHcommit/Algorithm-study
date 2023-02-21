//
//  main.swift
//  [baekjoon]9252
//
//  Created by 양승현 on 2023/02/21.
//

//https://dev-with-precious-dreams.tistory.com/200

import Foundation

let s1 = readLine()!.map{String($0)}
let s2 = readLine()!.map{String($0)}
var cache = Array(repeating: Array(repeating: 0, count: s2.count+1), count: s1.count+1)
for i in 1...s1.count {
    for j in 1...s2.count {
        if s1[i-1] == s2[j-1] {
            cache[i][j] = cache[i-1][j-1]+1
        }else {
            cache[i][j] = max(cache[i][j-1],cache[i-1][j])
        }
    }
}
if cache[s1.count][s2.count] == 0 {
    print(0)
}else {
    var res = ""
    var temp: [String] = []
    defer{ print(res) }
    var x = s2.count, y = s1.count
    while x>0 && y>0 {
        if cache[y-1][x] == cache[y][x] {
            y -= 1
        }else if cache[y][x-1] == cache[y][x] {
            x -= 1
        }else{
            //대각선 이전값에 부분 공통 문자열 + 1 되는 시점.
            x-=1
            y-=1
            temp.append(s2[x])
        }
    }
    
    res += "\(cache[s1.count][s2.count])\n\(temp.reversed().joined(separator: ""))"
}
