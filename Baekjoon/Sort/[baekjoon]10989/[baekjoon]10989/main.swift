//
//  main.swift
//  [baekjoon]10989
//
//  Created by 양승현 on 2022/03/30.
//

import Foundation

final class FileIO {
    private var buffer:[UInt8]
    private var index: Int

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        buffer = Array(fileHandle.readDataToEndOfFile())+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
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
              || now == 32 { now = read() } // 공백과 줄바꿈 무시
          if now == 45{ isPositive.toggle(); now = read() } // 음수 처리
          while now >= 48, now <= 57 {
              sum = sum * 10 + Int(now-48)
              now = read()
          }

          return sum * (isPositive ? 1:-1)
      }

      @inline(__always) func readString() -> String {
          var str = ""
          var now = read()

          while now == 10
              || now == 32 { now = read() } // 공백과 줄바꿈 무시

          while now != 10
              && now != 32 && now != 0 {
                  str += String(bytes: [now], encoding: .ascii)!
                  now = read()
          }
          return str
      }
  }
/**
 * seq라는 배열의 크기 10001 인 배열을 0으로 초기화하고
 * 특정한입력 값 == a라면
 * ++seq[a] 해당 값을 1 증가 시킨 후
 * 0이 아닌 값만 출력!
 */
let fIO = FileIO();
let n = fIO.readInt()
var seq : [Int] = Array(repeating: 0, count: 10001)
var res = ""
for _ in 0..<n {
    seq[fIO.readInt()] += 1
}
for i in 0..<10001{
    if seq[i] != 0 {
        for _ in 0..<seq[i]{
            res += "\(i)\n"
        }
    }
}

print(res)
