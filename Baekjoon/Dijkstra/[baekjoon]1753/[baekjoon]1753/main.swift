//https://icksw.tistory.com/93 참고했습니다.

import Foundation

public struct Heap<T>
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
    //heap은 루트노드를 반환한다.
    func peek() ->T?
    {
        return heap.first
    }
    
    /**
     * 힙 영역에 삽입할 때 우선 추가!
     * 그후에 상위 부모와 비교하면서 작으면 부모랑 자리 체인지
     * -> while 루트까지! 중간에 부모보다 크면 그만!
     */
    mutating func insert(_ element : T)
    {
        
        var index = heap.count
        heap.append(element)
        while index > 0 && !comparer(heap[index],heap[(index-1)/2])
        {
            heap.swapAt(index, (index-1)/2)
            index = (index-1)/2
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
        //루트 값 참조
        let result = heap.first
        // 힙의 가장 큰 값과 루트값 바꾸고
        heap.swapAt(0, heap.count - 1)
        //루트 반환 (이미 result에 참조)
        _ = heap.popLast()
        
        //이후 힙 조건 유지하는 작업이 필요함.
        
        var index = 0
        while index < heap.count
        {
            let left  = index * 2 + 1
            let right = left + 1
            
            //아직 아래에 비교해야할 노드가 있다면?
            if right < heap.count
            {
                if comparer(heap[left],heap[right]) &&
                    !comparer(heap[right],heap[index])
                {
                    heap.swapAt(right, index)
                    index = right
                }
                else if !comparer(heap[left], heap[index])
                {
                    heap.swapAt(left, index)
                    index = left
                }else
                {
                    break
                }
            }
            else if left < heap.count
            {
                if !comparer(heap[left],heap[index])
                {
                    heap.swapAt(left, index)
                    index = left
                }else
                {break}
            }else{break}
        }
        return result
    }
}
//헐 대박신기
extension Heap where T : Comparable
{
    init()
    {
        self.init(comparer: >)
    }
}


struct EdgeData : Comparable
{
    static func < (lhs : EdgeData , rhs : EdgeData )-> Bool
    {
        lhs.cost < rhs.cost
    }
    var cost : Int
    var node : Int
}

func BOJ_1753()
{
    let INF    = 9999999
    
    let VE     = readLine()!.split(separator: " ").map{Int($0)!}
    let vertex = VE[0]
    let edge   = VE[1]
    let start  = Int(readLine()!)! - 1
    
    var graph = Array(repeating: [(Int,Int)](), count: vertex)
    for _ in 0..<edge
    {
        var uvw = readLine()!.split(separator: " ").map{Int(String($0))!}
        graph[uvw[0] - 1].append((uvw[1] - 1,uvw[2]))
    }
    
    var distance = Array(repeating: INF, count: vertex)
    distance[start ] = 0
    
    var priorityQueue : Heap = Heap<EdgeData>()
    priorityQueue.insert(EdgeData(cost: 0, node: start))
    while(!priorityQueue.isEmpty)
    {
        let cur = priorityQueue.delete()!
        if distance[cur.node] < cur.cost
        {
            continue
        }
        
        for next in graph[cur.node]
        {
            if cur.cost + next.1 < distance[next.0]   
            {distance[next.0] = cur.cost + next.1
            priorityQueue.insert(EdgeData(cost: cur.cost + next.1, node: next.0))}
        }
    }
    
    for i in distance
    {
        if i == INF
        {
            print("INF")
        }
        else
            {print(i)}
    }
}
BOJ_1753()
