//
//  main.swift
//  11723
//
//  Created by 양승현 on 6/24/24.
//

import Foundation

@inline(__always) var buffer: [UInt8] = Array(FileHandle.standardInput.readDataToEndOfFile()) + [0], byteIdx = 0
@inline(__always) func readByte() -> UInt8 {
  defer { byteIdx += 1 }
  return buffer.withUnsafeBufferPointer { $0[byteIdx] }
}
@inline(__always) func read() -> Int {
  var number = 0, byte = readByte()
  while byte == 10 || byte == 32 { byte = readByte() }
  while 48...57 ~= byte { number = number * 10 + Int(byte - 48); byte = readByte() }
  return number
}
@inline(__always) func readString() -> Int {
  var byte = readByte()
  while byte == 10 || byte == 32 { byte = readByte() }
  var sum = Int(byte)
  while byte != 10 && byte != 32 && byte != 0 { byte = readByte(); sum += Int(byte) }
  return sum - Int(byte)
}
var set: Int32 = 0, res = ""
(0..<read()).forEach { _ in
  switch readString() {
  case 297: set |= 1<<read()
  case 654: set &= ~(1<<read())
  case 510: res += "\((set & 1<<read()) > 0 ? 1:0)\n"
  case 642: set ^= 1<<read()
  case 313: set |= 1<<21 - 1
  default: set = 0
  }
}
print(res)
