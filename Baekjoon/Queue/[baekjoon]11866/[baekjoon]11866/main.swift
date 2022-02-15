//  [baekjoon]11866
//  Created by 양승현 on 2022/02/15.
//  https://www.acmicpc.net/problem/11866

/**
 * *요세푸스 문제 0
 * 요세푸스 문제는 다음과 같다.
 
 *  1번부터 N번까지 N명의 사람이 원을 이루면서 앉아있고, 양의 정수 K(≤ N)가 주어진다. 이제 순서대로 K번째 사람을 제거한다. 한 사람이 제거되면 남은 사람들로 이루어진 원을 따라 이 과정을 계속해 나간다. 이 과정은 N명의 사람이 모두 제거될 때까지 계속된다. 원에서 사람들이 제거되는 순서를 (N, K)-요세푸스 순열이라고 한다. 예를 들어 (7, 3)-요세푸스 순열은 <3, 6, 2, 7, 5, 1, 4>이다.

 * N과 K가 주어지면 (N, K)-요세푸스 순열을 구하는 프로그램을 작성하시오.

 *****
 *  *예
 *  **input
 *  *7 3
 *  **output
 *  *<3, 6, 2, 7, 5, 1, 4>
 */
import Foundation
/**
 * 맨 처음에 사람을 지목하는 index(Queue에서는 top) 프로퍼티를 -1로 잡았다. *
 * array배열의 원소를 바로 바로 index로 호출할 수 있기 때문이다.
 * 내가 작성한 코드는. 두번째 입력값에 따라 전체 인원 N명 안에서, std(두번재 입력값(특정인원)) 번째마다 index를 지정하기 위해 for _ in 1...std{} 구문을 사용했다.
 * 그런데 나는 계속 3, 6, 2, 5 ... 값이 나왔다. 3과 6이 차례대로 지목되었을 때 아무런 조취를 하지 않았던 것이다.
 * 지목된 사람은 빠져야한다. for _ in 1... std{}에서 특정 index만큼 증가되었다면, array[index]이후 그 값을 -1로 만든다.
 * 또 이때 주의할 점은 array[index] == -1은 지목된 사람이 테이블에서 빠진것과 같은 의미이므로 건너 뛰어야한다.
 * 그것을 while array[index] == -1 구문을 통해 -1을 계속 만나면 그냥 계속 건너 뛰도록 index +=1을 했다.
 * array[index] == -1이면 index += 1을 해도 이미 빠진 사람이므로 count로 취급하지 않는다는 판단을 했다.
 * ********************************************* *********************************************
 * 첫번째 시도.
 * Queue를 만들어서 예를들어 1,2,3,4,5,6,7까지 있을때 첫번째 상황 '3'이 지목되기 전 1과 2를 차례로 deQueue한 후
 * enQueue를 했다. 이 방식으로 3씩 반복했는데, 시간초과가 났다.
 * N명까지 입력 데이터를 queue배열이라고 한다면,
 * 이때 deQueue에서 특정 index일 때
 * queue.remove(at: Index)를 사용했다. 이 방식은 특정 Index에서 배열을 삭제하면 그 뒷 원소들은 빈 자리를 한칸씩 당겨온다. 시간 복잡도 : O(n)
 * 이 방식으로 배열의 원소가 한개씩 주는데 이에 대한 특정한 인원수까지 건너뛰는 것을 계산했는데, 그 값이 매번 달라져서 실패했다.
 */
let input = readLine()!.split(separator: " ")
//첫번째 입력값
var N = Int(input[0])!
//두번째 입력값
let std = Int(input[1])!
var array = Array(1...N);
var index = -1;
var result : String = "<"
for row in 1...N{
    for _ in 1...std{
        index += 1
        if index >= N {
            index %= N
        }
        while array[index] == -1 {
            index += 1
            if index >= N {
                index %= N
            }
        }
    }
    //만약 row 가 마지막,  즉 array배열의 인원이 딱 한명 남은 경우 콤마를 찍지 않고 그냥 result로 추가.
    result += row == N ? "\(array[index])" : "\(array[index]), "
    array[index] = -1;
}
print(result + ">")

/**
class Queue {
    var queue : Array<Int>
    init(_ element : Int){
        queue = Array(1...element)
    }
    func enQueue(_ element : Int){
        queue.append(element);
    }
    func deQueue(_ index: Int) -> Int {
        return queue.remove(at: index)
    }
    var size : Int {
        queue.count
    }
}*/
