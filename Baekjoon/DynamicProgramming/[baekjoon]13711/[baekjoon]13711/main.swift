//
//  main.swift
//  [baekjoon]13711
//
//  Created by 양승현 on 2023/02/21.
//

import Foundation

// 라이노님의 FileIO
final class FileIO {
    private var buffer:[UInt8]
    private var index: Int
    
    init(fileHandle: FileHandle = FileHandle.standardInput) {
        buffer = Array(fileHandle.readDataToEndOfFile())+[UInt8(0)]
        index = 0
    }
    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }
        return buffer.withUnsafeBufferPointer { $0[index] }
    }
    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true
        while now == 10
                || now == 32 { now = read() }
        if now == 45{ isPositive.toggle(); now = read() }
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }
        return sum * (isPositive ? 1:-1)
    }
}
var file = FileIO()
var n=file.readInt()
var s1: [Int] = []
var t: [Int] = Array(repeating: 0, count: n)
var lists: [Int] = []
func binarySearch(_ seq: inout [Int], target: Int) {
    var l=0,r=seq.count-1,m=0
    defer{seq[r]=target}
    while l<r {
        m=(l+r)/2
        if target>seq[m] {l=m+1}
        else { r=m }
    }
}
func solution() {
    (0..<n).map{_ in s1.append(file.readInt())}
    (0..<n).map{ t[file.readInt()-1] = $0}
    (0..<n).map{ lists.append(t[s1[$0]-1]) }
    
    var seq: [Int] = [lists.first!]
    defer{print(seq.count)}
    (1..<s1.count).map{
        if lists[$0] > seq.last! { seq.append(lists[$0]) }
        else { binarySearch(&seq, target: lists[$0]) }
    }
}
solution()
