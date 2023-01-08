//
//  main.swift
//  [baekjoon]1927
//
//  Created by 양승현 on 2023/01/08.
//

import Foundation

var buffer: [UInt8] = Array(FileHandle.standardInput.readDataToEndOfFile()), byteIdx = 0; buffer.append(0)
@inline(__always) func readByte() -> UInt8 {
    defer { byteIdx += 1 }
    return buffer.withUnsafeBufferPointer { $0[byteIdx] }
}
@inline(__always) func readInt() -> Int {
    var number = 0, byte = readByte()
    while !(48...57 ~= byte) { byte = readByte() }
    while 48...57 ~= byte { number = number * 10 + Int(byte - 48); byte = readByte() }
    return number
}

//MARK: - Model
struct Heap<T> where T: Comparable {
    var list = [T]()
    let isLeftSmall: (T,T) -> Bool
    init(isLeftSmall: @escaping (T,T)->Bool) {
        self.isLeftSmall = isLeftSmall
    }
    init() {
        self.init(isLeftSmall: <)
    }
}
extension Heap {
    var isEmpty: Bool {
        return list.isEmpty
    }
    var count: Int {
        return list.count
    }
}
extension Heap {
    mutating func insert(_ element: T) {
        var idx = list.count
        list.append(element)
        while idx > 0 && isLeftSmall(list[idx],list[(idx-1)/2]) {
            list.swapAt(idx, (idx-1)/2)
            idx = (idx-1)/2
        }
    }
    mutating func delete() -> T? {
        guard !isEmpty else { return nil }
        guard count != 1 else { return list.popLast() }
        let element = list.first!
        list.swapAt(0, count-1)
        _ = list.removeLast()
        var idx = 0
        while idx < count {
            let (left,right) = (idx*2+1,idx*2+2)
            if right<count {
                if isLeftSmall(list[left],list[right]) && isLeftSmall(list[left],list[idx]) {
                    list.swapAt(left, idx)
                    idx = left
                } else if isLeftSmall(list[right],list[idx]) {
                    list.swapAt(right, idx)
                    idx = right
                } else {
                    break
                }
            }else if left<count{
                if isLeftSmall(list[left],list[idx]) {
                    list.swapAt(left, idx)
                    idx = left
                } else {
                    break
                }
            }else {
                break
            }
        }
        return element
    }
    
}

func solution() {
    var res = ""
    var minHeap = Heap<Int>()
    (0..<readInt()).forEach { _ in
        let value = readInt()
        if value == 0 {
            res += "\(minHeap.delete() ?? 0)\n"
        }else {
            minHeap.insert(value)
        }
    }
    print(res)
}

solution()
