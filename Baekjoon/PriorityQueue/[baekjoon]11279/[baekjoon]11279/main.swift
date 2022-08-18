//
//  main.swift
//  [baekjoon]11279
//
//  Created by 양승현 on 2022/08/18.
//

import Foundation

struct Heap<T> where T : Comparable
{
    var heap : [T] = []
    let comparer : (T,T) -> Bool
    var isEmpty : Bool
    {
        return heap.isEmpty
    }
    init(comparer : @escaping (T,T)->Bool)
    {
        self.comparer = comparer
    }
    init()
    {
        self.init(comparer: >)
    }
    mutating func insert(_ element : T)
    {
        var idx = heap.count
        heap.append(element)
        while idx > 0 && !comparer(heap[(idx-1)/2],heap[idx])
        {
            heap.swapAt(idx, (idx-1)/2)
            idx = (idx-1)/2
        }
    }
    mutating func delete() -> T?
    {
        guard !heap.isEmpty else
        {
            return nil
        }
        if heap.count == 1
        {
            return heap.removeFirst()
        }
        let result = heap.first
        heap.swapAt(0, heap.count-1)
        _ = heap.popLast()
        
        var idx = 0
        while idx < heap.count
        {
            
            let left  = idx * 2 + 1
            let right = left + 1
            //비교할수있는게 좌우있으면 뭐가 더 큰지 교체
            if right < heap.count
            {
                if comparer(heap[right],heap[left]) && comparer(heap[right],heap[idx])
                {
                    heap.swapAt(right,idx)
                    idx = right
                }
                else if comparer(heap[left],heap[idx])
                {
                    heap.swapAt(left, idx)
                    idx = left
                }
            }
            else if left < heap.count
            {
                //왼쪽은 왼쪽 인덱스만 비교해주면 됨.
                if comparer(heap[left],heap[idx])
                {
                    heap.swapAt(left,idx)
                    idx = left
                }
                else
                {
                    break
                }
            }
            else
            {
                break
            }
        }
        return result
    }
}
func BOJ_11279()
{
    let n    = Int(readLine()!)!
    var heap = Heap<Int>()
    for _ in 0..<n
    {
        let x = Int(readLine()!)!
        if x == 0
        {
            print("\(heap.delete() ?? 0)")
        }
        else
        {
            heap.insert(x)
        }
    }
}
BOJ_11279()
