//  main.swift
//  [Baekjoon]1068
//  Created by 양승현 on 2022/03/07.

import Foundation
/**
var N = Int(readLine()!)!
var input = readLine()!.split(separator: " ").map{Int($0)!}
var node = [Int : (left: Int?, right: Int?)]()
class BTree {
    var key : Int?
    var left : Int?
    var right : Int?
    init(_ key : Int?){
        self.key=key
    }
}
if (input.count == 1){
    node[0] = (nil, nil)
}
else if (input.count == 2){
    node[0] = (1,nil)
}else if input.count == 3{
    node[0] = (1,2)
}else{
    node[0] = (1,2)
    for i in 3..<input.count{
        /*if(i % 2 != 0) {
            if( (input.count - 1 - i) % 2 != 0 ){
                node[input[i]] = (i,i+1)
            }
            else{
                node[input[i]] = (i, nil)
            }
         }*/
        /*if ( i%2 == 1 ){
            if input[i] == input[i + 1] {
                node[input[i]] = (i, i+1)
            }else{
                node[input[i]] = (i, nil)
                if (input[i+1]==input[i+2])
            }
                    
        }*/
    }
}
/*
var del = Int(readLine()!)!
node[del] = nil;
var count = 0;
func dfs(_ key : Int){
    if node[key] == nil {
        return
    }
    count = count + 1
    dfs((node[key]?.left)!)
    dfs((node[key]?.right)!)
}

dfs(0)

print("\(count)")
*/
*/
/*
var N1 = Int(readLine()!)!
var BTree = [Int: node]()
var input : Array<Int> = readLine()!.split(separator: " ").map{
    BTree[Int($0)!] = node()
    return Int($0)!}
class node {
    var left : Int?
    var right : Int?
}
for i in 1..<input.count{
    /*if BTree[input[i]] == nil{
        BTree[input[i]] = node()
    }*/
    BTree[input[i]]?.left == nil ? {BTree[input[i]]?.left = i}() : {BTree[input[i]]?.right = i}()
    /*if(BTree[input[i]]?.left == nil)
    {
        BTree[input[i]]?.left = i
    }else if(BTree[input[i]]?.right == nil){
        BTree[input[i]]?.right = i
    }*/
}

var del = Int(readLine()!)!
BTree[del] = nil;
var count = 0;
func dfs(_ key : Int){
    if BTree[key] == nil {
        return
    }
    count = count + 1
    dfs((BTree[key]?.left)!)
    dfs((BTree[key]?.right)!)
}
dfs(0)
print("\(count)")*/
import Foundation
var N = Int(readLine()!)!
var BTree = [Int: node]()
var input : Array<Int> = readLine()!.split(separator: " ").map{Int($0)!} // 트리 구성 배열로 받았습니다.
var del = Int(readLine()!)! //삭제할 값
class node {
    var left : Int?
    var right : Int?
}
//차례대로 특정 부모노드(BTree[input[i]])일 때 왼쪽, 오른쪽으로 순차적인 값 대입하는 포문입니다.
for i in 1..<N{
    if BTree[input[i]] == nil {
        BTree[input[i]] = node()
    }
    //BTree[input[i]]?.left == nil ? {BTree[input[i]]?.left = i}() : {BTree[input[i]]?.right = i}()
    if(BTree[input[i]]?.left == nil)
    {
        BTree[input[i]]?.left = i
    }else if(BTree[input[i]]?.right == nil){
        BTree[input[i]]?.right = i
    }
}
//삭제할 부모노드입니다. // 자식도 다 삭제.
BTree[del] = nil;
var cnt = 0;
func dfs(_ key : Int){
    if BTree[key] == nil {
        return
    }
    cnt = cnt + 1
    dfs((BTree[key]?.left)!)
    if BTree[key]?.right != nil{
    dfs((BTree[key]?.right)!)
    }
}
//dfs로 이진트리 탐색
dfs(0)
print("\(cnt)")
