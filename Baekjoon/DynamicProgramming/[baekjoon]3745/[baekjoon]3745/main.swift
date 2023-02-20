//
//  main.swift
//  [baekjoon]3745
//
//  Created by 양승현 on 2023/02/20.
//

import Foundation

var res = ""

var buffer: [UInt8] = Array(FileHandle.standardInput.readDataToEndOfFile()), byteIdx = 0; buffer.append(0)
@inline(__always) func readByte() -> UInt8 {
    defer { byteIdx += 1 }
    let bp = buffer.withUnsafeBufferPointer { $0[byteIdx] }
    if bp == 0 { print(res); exit(0) } // 여기서 EOF 처리
    return bp
}
@inline(__always) func readInt() -> Int {
    var number = 0, byte = readByte(), isNegative = false
    while byte == 10 || byte == 32 { byte = readByte() }
    if byte == 45 { byte = readByte(); isNegative = true }
    while 48...57 ~= byte { number = number * 10 + Int(byte - 48); byte = readByte() }
    return number * (isNegative ? -1 : 1)
}


func binarySearch(_ seq: inout [Int], target: Int) {
    var l = 0, r = seq.count-1, mid = 0
    while l<r {
        mid = (l+r)/2
        if target>seq[mid] { l = mid+1 }
        else { r=mid }
    }
    seq[r]=target
}
func solution() {
    while true {
        let n = readInt()
        //궁금한건 왜 내가 한 이 코드는 안될까? 무수히 많은 공백 사이에 공백만있다면 return되는데,,
        // 무수히 많은 공백 사이에 숫자 한개 있으면 아래 문장 실행되는데..
//        guard true == readLine()?.split{$0==" "}.map{$0}.contains(where: {$0 != ""}) else { return }
        //let lists = readLine()!.split{$0==" "}.map{Int(String($0))!}
        let lists = (0..<n).map{_ in readInt()}
        var seq = [lists.first!]
        (1..<lists.count).map{
            if lists[$0] > seq.last! { seq.append(lists[$0]) }
            else { binarySearch(&seq, target: lists[$0]) }
        }
        res += "\(seq.count)\n"
    }
}
solution()
