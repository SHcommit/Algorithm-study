//  [baekjoon]1991
//  Created by 양승현 on 2022/02/24.
//  https://www.acmicpc.net/problem/1991
/**
 *1991번 : 트리 순회*
 *Level : Silver 1 tier
 */
import Foundation
// 트리에 사용되는 노드는 key, leftSubtree,rightSubtree, parent를 지목할 수 있어야한다.
class BinaryTreeNode<T : Comparable> {
    public var key : T
    public var leftSubtree : BinaryTreeNode?
    public var rightSubtree : BinaryTreeNode?
    public var parent: BinaryTreeNode?
    
    init(key :T , leftSubtree left :BinaryTreeNode?, rightSubtree right: BinaryTreeNode?, parent : BinaryTreeNode?){
        self.key = key;
        self.leftSubtree = left
        self.rightSubtree = right
        self.parent = parent
    }
    
    convenience init(key : T){
        self.init(key: key, leftSubtree: nil, rightSubtree: nil, parent: nil)
    }
    
    private func addNode(key : T){
        if key < self.key{
            if let leftSubtree = leftSubtree {
                leftSubtree.addNode(key: key)
            }
            else{
                let newNode = BinaryTreeNode(key: key)
                newNode.parent = self
                self.leftSubtree = newNode
            }
        }
        else{
            if let rightSubtree = rightSubtree {
                rightSubtree.addNode(key: key)
            }
            else{
                let newNode = BinaryTreeNode(key: key)
                newNode.parent = self
                self.rightSubtree = newNode;
            }
        }
    }
    public func insertNodeFromRoot(key: T){
        if let _ = self.parent {
            print("노드 중간에 자식이 삽입될 수 없습니다. 루트 기준 key 값 기준 붕괴")
            return
        }
        self.addNode(key: key)
    }
    class func preOrder(node : BinaryTreeNode?){
        guard let node = node else {
            return
        }
        print(node.key)
        BinaryTreeNode.preOrder(node: node.leftSubtree)
        BinaryTreeNode.preOrder(node: node.rightSubtree)
    }
    class func inOrder(node: BinaryTreeNode?){
        guard let node = node else{
            return
        }
        BinaryTreeNode.inOrder(node: node.leftSubtree)
        print(node.key)
        BinaryTreeNode.inOrder(node: node.rightSubtree)
    }
    class func postOrder(node: BinaryTreeNode?){
        guard let node = node else{
            return
        }
        BinaryTreeNode.postOrder(node: node.leftSubtree)
        print(node.key)
        BinaryTreeNode.postOrder(node: node.rightSubtree)
    }
}
