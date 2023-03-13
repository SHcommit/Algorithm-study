//
//  main.swift
//  [baekjoon]12605
//
//  Created by 양승현 on 2023/03/13.
//

import Foundation
//
//(1...Int(readLine()!)!).map{
//    print("Case #\($0): \(readLine()!.split{$0==" "}.reversed().joined(separator: " "))")
//}


struct Stack<T> {
    typealias Element = T
    private var lists: [Element]
    init(lists: [Element] = [Element](), type: Element.Type) {
        self.lists = lists
        
    }
}
extension Stack {
    mutating func push(_ element: Element) {
        lists.append(element)
    }
    mutating func pop() -> Element?{
        guard count != 0 else { return nil }
        return lists.removeLast()
    }
    var count: Int {
        return lists.count
    }
    var top: Element {
        return lists[count-1]
    }
}

_=(1...Int(readLine()!)!).map{ caseIndex in
    var stack = Stack(type: String.self)
    var reversedText = ""
    for text in readLine()!.split{$0==" "} {
        stack.push(String(text))
    }
    while let text = stack.pop() {
        reversedText += "\(text) "
    }
    print("Case #\(caseIndex): \(reversedText)")
}
//a b c d e ff gg ghhh i j kkk
