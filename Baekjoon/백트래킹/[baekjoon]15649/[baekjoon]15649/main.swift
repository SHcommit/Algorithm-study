//
//  main.swift
//  [baekjoon]15649
//
//  Created by 양승현 on 2022/03/30.
//

import Foundation

//input[0] == n
//input[1] == m
var input = readLine()!.split(separator: " ").map{Int(String($0))!}


var visit = Array(repeating: false, count: 9)
var stack = [Int]()

var res  = ""

func dfs(index :Int){
    if index > input[1]{
        //seq.reversed()
        stack.forEach{
            res += "\($0) "
        }
        res += "\n"
        return;
    }

    for i in 1...input[0]{
        if(!visit[i]){
            visit[i] = true;
            stack.append(i);
            dfs(index: index + 1)
            stack.popLast()
            visit[i] = false;
        }
    }
}

dfs(index: 1)
print(res);
