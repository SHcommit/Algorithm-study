//
//  main.swift
//  [baekjoon]12605
//
//  Created by 양승현 on 2023/03/13.
//

import Foundation

(1...Int(readLine()!)!).map{
    print("Case #\($0): \(readLine()!.split{$0==" "}.reversed().joined(separator: " "))")
}


struct Stack {
    private var lists: [String]
    init(lists: [String] = [String]()) {
        self.lists = lists
    }
}
extension Stack {
    mutating func push(_ element: String) {
        lists.append(element)
    }
    mutating func pop() -> String?{
        guard count() != 0 else { return nil }
        return lists.removeLast()
    }
    func count() -> Int {
        return lists.count
    }
    func top() -> String {
        return lists[count()-1]
    }
}

_=(1...Int(readLine()!)!).map{ caseIndex in
    var stack = Stack()
    var reversedText = ""
    for text in readLine()!.split{$0==" "} {
        stack.push(String(text))
    }
    while let text = stack.pop() {
        reversedText += "\(text) "
    }
    print("Case #\(caseIndex): \(reversedText)")
}
