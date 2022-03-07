//  main.swift
//  [backjoon]1991_secTry
//  Created by 양승현 on 2022/03/07.

import Foundation

var N = Int(readLine()!)!
var BTree = [String:(left: String, right : String)]()
for _ in 0..<N {
    var input :Array<String> = readLine()!.split(separator: " ").map{
        if $0 == "." {
            return ""
        }
        return String($0)
    }
    BTree[input[0]] = (left: input[1], right: input[2])
}
let Root = "A"
var preOrder = ""
var inOrder = ""
var postOrder = ""
func dfs(_ node: String){
    if node == ""{
        return
    }
    preOrder = preOrder + node
    dfs(BTree[node]!.left)
    inOrder = inOrder + node
    dfs(BTree[node]!.right)
    postOrder = postOrder + node
}
dfs(Root)
print(preOrder)
print(inOrder)
print(postOrder)
