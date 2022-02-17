//  [baekjoon]1966
//  Created by 양승현 on 2022/02/16.
//  https://www.acmicpc.net/problem/1966
/**
 * *프린터 큐

 * 여러분도 알다시피 여러분의 프린터 기기는 여러분이 인쇄하고자 하는 문서를 인쇄 명령을 받은 ‘순서대로’, 즉 먼저 요청된 것을 먼저 인쇄한다. 여러 개의 문서가 쌓인다면 Queue 자료구조에 쌓여서 FIFO - First In First Out - 에 따라 인쇄가 되게 된다. 하지만 상근이는 새로운 프린터기 내부 소프트웨어를 개발하였는데, 이 프린터기는 다음과 같은 조건에 따라 인쇄를 하게 된다.
 
 * 현재 Queue의 가장 앞에 있는 문서의 ‘중요도’를 확인한다.
  나머지 문서들 중 현재 문서보다 중요도가 높은 문서가 하나라도 있다면, 이 문서를 인쇄하지 않고 Queue의 가장 뒤에 재배치 한다. 그렇지 않다면 바로 인쇄를 한다.
  예를 들어 Queue에 4개의 문서(A B C D)가 있고, 중요도가 2 1 4 3 라면 C를 인쇄하고, 다음으로 D를 인쇄하고 A, B를 인쇄하게 된다.

 * 여러분이 할 일은, 현재 Queue에 있는 문서의 수와 중요도가 주어졌을 때, 어떤 한 문서가 몇 번째로 인쇄되는지 알아내는 것이다. 예를 들어 위의 예에서 C문서는 1번째로, A문서는 3번째로 인쇄되게 된다.
 ****
 * 입력
 * 첫 줄에는 TestCase 수.
 *      * 위에서 TestCase는 두 줄로 이루어져 있다.
 *          * (첫번째 줄) 1. <문서 개수> N  <어떤 한 문서가 Queue에서 몇 번째로 놓여있는가?> M
 *          * (두번째 줄) 1 <첫번째 줄에서 주어진>N개 문서의 중요도가 차례대로 주어짐.
 * 이때 맨 왼쪽은 0 번째 부터 시작한다.
 *  ex) TestCase 의 (첫번째 줄) N = 3 M = 2이고
 *              (두번째 줄) 1 8 6 이라 주어진다면, M(index == 2) 즉 중요도 6 인 문서가 주어진 List에서 몇번째로 출력이 되는가?
 *  2번째로 출력된다.
 *****
 *  * 예
 *  ** input
 *  * 3 <TestCase 개수>
 *  * 1 0 <TestCase 1: 첫번째 줄>
 *  * 5 <TestCase 1: 두번째 줄>
 *  * 4 2 <TestCase 2: 첫번째 줄>
 *  * 1 2 3 4 <TestCase 2: 두번째 줄>
 *  * 6 0 <TestCase 3: 첫번째 줄>
 *  * 1 1 9 1 1 1 <TestCase 3: 두번째 줄>
 *  ** output
 *  * 1 <TestCase 1: M에 대한 결과>
 *  * 2 <TestCase 1: M에 대한 결과>
 *  * 5 <TestCase 1: M에 대한 결과>
 */
import Foundation

class Queue {
    var queue = Array<Int>()
    var maxValue = 0
    var index : Int
    var M : Int; // 특정 index
    var cnt : Int // 큰 중요도부터 차례대로 출력되는거 카운트 변수.
    var flag : Bool
    init(){
        index = 0;
        flag = false;
        var firstLine = readLine()!.split(separator: " ")
        var secondLine = readLine()!.split(separator: " ")
        var list = Array<Int>()
        
        M = Int(firstLine[1])!
        for i in 0..<secondLine.count{
            list.append(Int(secondLine[i])!); //마지막 부분 secondLine()안되네,,
        }
    }
    func enqueue(_ element: Int){
        queue.append(element);
    }
    func dequeue() -> Int{
        
    }
}

var result : String = "";
var input = readLine()!

for _ in 1...Int(input)!{
    var q = Queue();
    while(q.flag != true){
        //큰경우 , 같은경우, 작은경우는 출력!
        if q.maxValue > q.queue[q.index] {
            if q.queue[q.index] < q.queue[q.index + 1]{
                
            }
        } else if
    }
}
