//  main.swift
//  [Baekjoon]1068
//  Created by μμΉν on 2022/03/07.

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
var input : Array<Int> = readLine()!.split(separator: " ").map{Int($0)!} // νΈλ¦¬ κ΅¬μ± λ°°μ΄λ‘ λ°μμ΅λλ€.
var del = Int(readLine()!)! //μ­μ ν  κ°
class node {
    var left : Int?
    var right : Int?
}
//μ°¨λ‘λλ‘ νΉμ  λΆλͺ¨λΈλ(BTree[input[i]])μΌ λ μΌμͺ½, μ€λ₯Έμͺ½μΌλ‘ μμ°¨μ μΈ κ° λμνλ ν¬λ¬Έμλλ€.
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
//μ­μ ν  λΆλͺ¨λΈλμλλ€. // μμλ λ€ μ­μ .
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
//dfsλ‘ μ΄μ§νΈλ¦¬ νμ
dfs(0)
print("\(cnt)")
