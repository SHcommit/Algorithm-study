//
//  main.swift
//  [baekjoon]17298
//
//  Created by 양승현 on 2022/03/09.
//

import Foundation
let n = Int(readLine()!)!
var NGE = readLine()!.split(separator: " ").map{ Int($0)!}
var stack = [Int]()

for i in 0..<n {
    while !stack.isEmpty && (NGE[stack.last!] < NGE[i] ){
        NGE[stack.popLast()!] = NGE[i]
    }
    stack.append(i)
}
for i in stack {
    NGE[i] = -1
}
print(NGE.map{String($0)}.joined(separator: " "))

/**
var N = Int(readLine()!)!
var input = readLine()!.split(separator: " ").map { Int($0)!}
var stack = Array<Int>()
var res = ""
var cnt : Int
for i in 0..<N {
    cnt = 0
    var maxValue = 0
    
    //위 아래 포문 중복됨
    for j in i+1..<N {
        if input[i] < input[j]{
            cnt = cnt + 1
            stack.append(input[j])
        }
    }
    if cnt == 0{
        res = res + "-1 "
    }else{
        maxValue = stack.removeLast()
        for _ in 0..<stack.count{
            var tmp = stack.removeLast()
            if maxValue > tmp {
                maxValue = tmp
            }
        }
        res = res + "\(maxValue) "
    }
}
print("\(res)")
*/
/*
var N = Int(readLine()!)!
var input = readLine()!.split(separator: " ").map { Int($0)!}
var NGE = Array<Int>()
var res = ""


for i in 0..<input.count{
    if i == input.count - 1 {
        res = res + "-1"
        break
    }
    var j = i
    for j in i..<input.count{
        if(input[i]<input[j]){
            NGE.append(input[j])
        }
    }
    guard var min = NGE.popLast() else {
        res = res + "-1 "
        continue
    }
    while(!NGE.isEmpty){
        if min > NGE.last!{
            min = NGE.popLast()!
            continue
        }
        NGE.removeLast()
    }
    res = res + "\(min) "
}
print(res)

*/



//4
//9 5 4 8
/*
var N = Int(readLine()!)!
var input = readLine()!.split(separator: " ").map { Int($0)!}
var stack = input
var res = ""
var cnt : Int
for i in 0..<N {
    stack.filter(){ $0 > input[i] }
    if stack.isEmpty == true {
        res = res + "-1 "
    }
    
    if i == N-1 {
        break
    }
}
*/
