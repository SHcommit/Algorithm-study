//  main.swift
//  [baekjoon]1991_secTry
//  Created by 양승현 on 2022/03/07.
/**
 *오늘 많은 것을 배웠다.
 *for in 대신 map을 활용해서 readLine()!.split(separator: " ")로 받아지는 arraySlice를
 *  map의 트레일링클로저를 이용해 String으로 바꿔 . String타입의 배열로 저장하고,
 *
 *Dictionary를 활용해 [String , (String, String)] 특정 키값은 좌, 우 자식들을 갖도록하는 딕셔너리 선언
 *최초로 삽입된 key값(루트)을 통해서 고유값인 key는 출력되지 않지만,
 *  딕셔너리의 성질을 이용해 자식들을 데이터로 이용할 수 있다.
 *Dictionary = [<key>: <데이터>]*
 *
 *딕셔너리가 순차적으로 저장된 것은 아니다.
 *하지만,
 *특정 부모값이 주어진다면,
 *예를들어 루트값이 주어진다면?
 *   그값을 최초의 key값으로 활용해 튜플로 저장된 자식들 left, right 값을 얻을 수 있다.
 *이 자식들 또한 key값으로 저장되어있어, 또 하위자식들을 호출할 수 있다...크....
 *********************************************************
 *함수 dfs는 이진트리에서 자식이 있을 경우 left자식, 없다면  right자식이 있는 부모노드로 되돌아와
 *right자식에서 또 left가 있으면 left,,로 left자식을 우선으로 탐색한다.
 *
 *이때 전위, 중위, 후위 또한 특정 노드 시점 left -> right로 탐색을 하는데,
 *전위 : print(node) left right
 *중위 : left print(node) right
 *후위 : left right print(node)
 *로 현재 노드가 출력되는 순위만 다르다는 것!!
 */
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
    //딕셔너리에서 특정 키값에 데이터를 저장하는 방법~!!
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
