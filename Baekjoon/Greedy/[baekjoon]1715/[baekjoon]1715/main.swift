import Foundation

struct MinHeap<T> where T: Comparable{
    
    typealias Comparer = (T,T) -> Bool
    
    private var heap: [T] = []
    
    var comparer: Comparer
    
    init(callback: @escaping Comparer){
        self.comparer = callback
    }
    
    init() {
        self.init(callback: <)
    }
    
    mutating func insert(_ element: T) {
        var idx = count()
        append(element)
        while idx > 0 && comparer(heap[idx],heap[(idx-1)/2]) {
            swapAt(idx, (idx-1)/2)
            idx = (idx-1)/2
        }
        
    }
    
    mutating func delete() -> T? {
        guard !heap.isEmpty else {
            return nil
        }
        
        guard count() != 1 else {
            return heap.removeFirst()
        }
        
        let result = first()
        var idx = 0
        swapAt(0, count()-1)
        removeLast()
        /*
         몇가지의 경우를 따져야하냐면
         자식 노드가 두개 인 경우.
            
         자식노드가 한 개인 경우.
         자식 노드가 없느 경우.
         */
        while idx < count() {
            
            let left = idx*2 + 1
            let right = left+1
            
            if right < count() {
                if comparer(heap[left],heap[right]) && comparer(heap[left],heap[idx]) {
                    swapAt(idx, left)
                    idx = left
                }else if comparer(heap[right],heap[idx]) {
                    swapAt(idx, right)
                    idx = right
                }else{
                    break
                }
            } else if left < count() {
                if comparer(heap[left],heap[idx]) {
                    swapAt(idx, left)
                    idx = left
                }else {
                    break
                }
            } else {
                break
            }
        }
        return result
    }
}

extension MinHeap {
    
    func isEmpty() -> Bool {
        return self.heap.isEmpty
    }
    
    func count() -> Int {
        return self.heap.count
    }
    
    func first() -> T? {
        return self.heap.first
    }
    mutating func removeLast() -> T? {
        return self.heap.removeLast()
    }
    mutating func swapAt(_ a: Int, _ b: Int) {
        self.heap.swapAt(a, b)
    }
    
    mutating private func append(_ element: T) {
        self.heap.append(element)
    }
    
}

class BOJ1715 {
    var priorityQueue = MinHeap<Int>()
    
    func solution() {
        
        let n = Int(readLine()!)!
        var sum = 0
        defer{
            print(sum)
        }
        for _ in 0..<n {
            priorityQueue.insert(Int(readLine()!)!)
        }
        while priorityQueue.count() > 1 {
            let a = priorityQueue.delete()!
            let b = priorityQueue.delete()!
            sum += a + b
            priorityQueue.insert(a+b)
        }
    }
}

BOJ1715().solution()
