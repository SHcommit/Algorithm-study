//  [baekjoon]1991
//  Created by 양승현 on 2022/02/24.
//  https://www.acmicpc.net/problem/1991
/**
 *1991번 : 트리 순회*
 *Level : Silver 1 tier
 */
import Foundation
/*
 * 트리에 사용되는 노드는 key, leftSubtree,rightSubtree, parent를 지목할 수 있어야한다.
 * leftSubtree : 옵셔널 타입인데. 기본적으로 클래스는 reference로 참조가 가능하다. nil이 아닐 경우 해당 인스턴스를 참조한다고 보면 된다.
 * convenience init 는 보조 init
 */
class BTNode{
    var key : String
    var left : BTNode?
    var right : BTNode?
    
    init(key : String , leftSubtree left : BTNode?, rightSubtree right : BTNode? ){
        self.key = key
        self.left = left
        self.right = right
    }
    convenience init(key : String){
        self.init(key: key, leftSubtree: nil, rightSubtree: nil)
    }
    class func preOrderSearch(key : String ,node : BTNode?, tmpParent : inout BTNode?) {
        if node == nil {
            return
        }
        else if key == node!.key {
            tmpParent = node
            return
        }
        BTNode.preOrderSearch(key : key, node: node?.left, tmpParent : &tmpParent)
        BTNode.preOrderSearch(key : key, node: node?.right, tmpParent: &tmpParent)
    }
    func addNode(key : String , node : BTNode?, index : Int){
        if key != "." {
            if (index == 1 ){
                let newNode = BTNode(key: key)
                node?.left = newNode
                return
            }
            else if (index == 2){
                let newNode = BTNode(key:key)
                node?.right = newNode
                return
            }
        }
        else{
            if (index == 1 ){
                node?.left = nil
                return
            }
            else if index == 2 {
                node?.right = nil
                return
            }
        }
    }
    class func preOrder(node : BTNode?,result : inout String){
        guard let node = node else {
            return
        }
        result = result + node.key
        BTNode.preOrder(node: node.left, result : &result)
        BTNode.preOrder(node: node.right, result : &result)
    }
    static func inOrder(node : BTNode? , result: inout String){
        guard let node = node else {
            return
        }
        BTNode.inOrder(node: node.left, result: &result)
        result = result + node.key
        BTNode.inOrder(node: node.right, result: &result)
    }
    class func postOrder(node : BTNode? , result : inout String) {
        guard let node = node else{
            return
        }
        postOrder(node: node.left, result: &result)
        postOrder(node: node.right, result: &result)
        result = result + node.key
    }
}

var N = Int(readLine()!)!
var tree : BTNode?
for i in 0..<N {
    var Node = readLine()!.split{ $0 == " "}
    if i == 0 {
        tree = BTNode(key: String(Node[0]))
    }
    var tmpParentNode : BTNode?
    for index in 0..<Node.count{
        if index == 0{
            BTNode.preOrderSearch(key: String(Node[index]), node: tree, tmpParent: &tmpParentNode)
        }else if index == 1{
            tree!.addNode(key: String(Node[index]), node: tmpParentNode, index: index)
        }else if index == 2{
            tree!.addNode(key: String(Node[index]), node: tmpParentNode, index: index)
        }
        
    }
}

for i in 0..<3{
    var result :String = ""
    if i == 0{
        BTNode.preOrder(node: tree, result: &result)
        print("\(result)")
    }
    else if i == 1{
        BTNode.inOrder(node: tree, result: &result)
        print("\(result)")
    }
    else {
        BTNode.postOrder(node: tree, result: &result)
        print("\(result)")
    }
}
