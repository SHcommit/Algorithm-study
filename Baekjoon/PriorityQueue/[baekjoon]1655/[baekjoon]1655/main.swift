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

        while now == 10 || now == 32 { // 공백과 줄바꿈 무시
            now = read()
        }
        
        if now == 45{ // 음수 처리
            isPositive.toggle()
            now = read()
        }
        
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

struct Heap<T> where T: Comparable{
    
    typealias Comparer = (T,T) -> Bool
    var heap: [T] = []
    var comparer: Comparer
    var left = 0 , right = 0
    var isHeapify = false
    
    init(callback: @escaping (T,T)->Bool){
        self.comparer = callback
    }
    
    mutating func insert(_ element: T) {
        var index = heap.count
        heap.append(element)
        
        while index>0 && comparer(heap[(index-1)/2],heap[index]) {
            heap.swapAt(index, (index-1)/2)
            index = (index-1)/2
        }
    }
    
    mutating func delete() -> T? {
        
        guard !heap.isEmpty else {
            return nil
        }
        
        guard heap.count != 1 else {
            return heap.removeFirst()
        }
        
        let result = heap.first
        var index = 0
        isHeapify = false
        heap.swapAt(index, heap.count - 1)
        heap.removeLast()
        
        while index < heap.count && !isHeapify {
            left = index*2 + 1
            right = left + 1
            if right < heap.count {
                hasTwoChild(&index)
            } else if left < heap.count {
                hasSingleChild(&index)
            } else {
                isHeapify = true
            }
        }
        return result
    }
}

extension Heap {
    
    init() {
        self.init(callback: <)
    }
    
    mutating func hasTwoChild(_ index: inout Int) {
        if comparer(heap[left],heap[right]) && comparer(heap[left],heap[index]) {
            heap.swapAt(left, index)
            index = left
        }else if comparer(heap[right],heap[index]) {
            heap.swapAt(right, index)
            index = left
        }else {
            isHeapify = true
        }
    }
    
    mutating func hasSingleChild(_ index: inout Int) {
        if comparer(heap[left],heap[index]) {
            heap.swapAt(left, index)
            index = left
        } else {
            isHeapify = true
        }
    }
}

class BOJ_1655 {
    var n: Int
    var list: [Int]
    
    init() {
        let fIO = FileIO()
        n = fIO.readInt()
        list = [Int]()
        for _ in 0..<n {
            list.append(fIO.readInt())
        }
    }
    
    func solution() {
        var minHeap = Heap<Int>(callback: >)
        var maxHeap = Heap<Int>()

        maxHeap.insert(list[0])
        
        guard n != 1 else {
            return
        }
        
        for i in 1...n {
            
            if list.count == 1 {
                print("\(list[0])")
                return
            }
            else if minHeap.heap.count == maxHeap.heap.count {
                maxHeap.insert(list[index])
            }else {
                minHeap.insert(list[index])
            }
            
            if !maxHeap.heap.isEmpty && !minHeap.heap.isEmpty && maxHeap.heap.first! > minHeap.heap.first! {
                let a = maxHeap.delete()!
                let b = minHeap.delete()!
                maxHeap.insert(b)
                minHeap.insert(a)
            }
            print("\(maxHeap.heap.first!)")
        }
    }
    
}
BOJ_1655().solution()
