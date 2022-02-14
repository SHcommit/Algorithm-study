//  [baekjoon]2164
//  Created by 양승현 on 2022/02/14.
//  https://www.acmicpc.net/problem/2164

import Foundation
/**
 * 초기 구현했던 Queue는 큐에 삽입, 삭제를 할 수 있는 var data =  [Int]() 배열 한개를 선언하고,
 * 첫번째 원소 삭제 방법을 아래와 같이 구현했다.
 * func deQueue() -> Int{
 *   if !isEmpty {
 *       return -1
 *   }
 *   return data.removeFirst()
 * }
 * removeFirst() 를 사용했는데, 첫원소는 return, 빈 나머지 원소를 한칸씩 앞당겨주는 메서드이다.
 * 하지만 시간초과가 났다.
 * removeFirst() 는  첫번째 원소를 제외한 나머지 배열을 파라미터(매개변수)로 전달하고, data가 이 배열을 받는 것 같다.
 *      삭제한 나머지 원소를 복사하여 data에 전달?.
 * 시간 복잡도는 O(n) 아래 구현현 방식으로 큐의 저장된 배열을 reversed()한 후 첫번째 원소가 맨 마지막원소가되어 맨 마지막 원소만
 **
 * pop작업을 하는 rearQ.popLast()는 시간복잡도O(1)이다.
 * removeFirst()는 매번 호출될 때마다 특정 원소가 삭제되고, 나머지 원소가 복사되기 때문에 O(n)이 소요된다.
 * 한 두번은 괜찮겠지 라는 생각에, 썼는데 RemoveFirst()를 사용했는데, 확실히 백준 사이트에서는 엄청 느리게 작동된다.
 * * 다음 부턴 시간 복잡도 n보단 상수시간에 가까운 시간복잡도를 정확히 고려하여 코드를 구성할 것이다.
 * * 이전에 구현한 코드는 길이가 700 지금은 대략 1200인데, 코드가 길면 오히려 느려지겠지 라는 생각에 removeFirst()를 사용한 것이다.
 *   하지만 **코드의 간결함** 보다 코드가 좀 길더라도 **계속 반복될 때의 시간 복잡도**가 중요하다는 것을 알게 되었다.
 */
class Queue {
    private var frontQ : Array<Int>
    private var rearQ = Array<Int>()
    init (_ input: Int){
        frontQ = Array(1...input)
    }
    func enQueue(_ element: Int){
        frontQ.append(element)
    }
    func deQueue() -> Int{
        if isEmpty{
            return -1
        }
        if rearQ.isEmpty{
            rearQ = frontQ.reversed()
            frontQ.removeAll()
        }
        return rearQ.popLast()!
    }
    var size :Int {
        frontQ.count + rearQ.count
    }
    var isEmpty: Bool{
        rearQ.isEmpty && frontQ.isEmpty
    }
    var front : Int {
        if !isEmpty {
            return rearQ.isEmpty ? frontQ.first! : rearQ.last!
        }
        return -1
    }
}
let input = Int(readLine()!)!
var q = Queue(input);
//input == 1 일때,
if q.size == 1 {
    print("1");
    exit(0)
}
//input != 1
while q.size > 1 {
    
    if q.size != 2 {
        //배열 index 3 이상 일 때. 한개는 deQ(), 연이어 또 deQ()이후 그 값을 enQ()
        q.deQueue()
        q.enQueue(q.deQueue())
    }else {//2만 남았을 때 한개 deQ()나머지 출력
        q.deQueue()
        print("\(q.front)")
        break;
    }
}
