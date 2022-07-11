import Foundation
//https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-1946-%EC%8B%A0%EC%9E%85-%EC%82%AC%EC%9B%90

typealias Element = (document: Int, interview : Int)


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
    
    @inline(__always) func readString() -> String {
        var str = ""
        var now = read()
        
        while now == 10
                || now == 32 { now = read() }
        
        while now != 10
                && now != 32 && now != 0 {
            str += String(bytes: [now], encoding: .ascii)!
            now = read()
        }
        
        return str
    }
}

func BOJ_1946()
{
    let file  = FileIO()
    var res = ""
    
    for _ in 0..<file.readInt()
    {
        var list  = [Element]()
        var pass  = 0
        var count = 1
        for _ in 0..<file.readInt()
        {
            list.append((file.readInt(),file.readInt()))
        }
        
        list.sort(by: )
        {
            return $0.interview < $1.interview
        }
        pass = list[0].document
        
        for i in 1..<list.count
        {
            if pass > list[i].document
            {
                pass = list[i].document
                count += 1
            }
        }
        res += "\(count)\n"
    }
    print(res)
}
BOJ_1946()

