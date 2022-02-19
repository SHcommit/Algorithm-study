import Foundation
/**
 * #삽입정렬
 * 이미 정렬 되어있는 배열 i 에 한개의 원소 i+1 를 추가 한 후의 정렬된 i+1배열을 만드는 과정의 반복.
 * 시간 복잡도 : O(2n)
 * 어느 정도 정렬된 배열이라면 삽입정렬의 효율성 Good.
 */
func insertIionSort(_ array: inout Array<Int>){
    if array.count <= 1 {
        return;
    }
    for i in 1..<array.count{
        let newItem = array[i];
        var j = i;
        while (j > 0 && array[j-1] > newItem){
            //두번째 조건이라면
            array[j] = array[j-1]
            j -= 1
        }
        array[j] = newItem
    }
}
/**
 * 코드 리뷰( TMI )
 * 정렬되지 않은 배열
 * var array = [ 8,3,9,13,11] 이 인자값으로 주어진다면.
 * for in 구문에서 i == 1을 실행 할 때
 *  <index 0> 인 원소 8은 이미 정렬되어있는 배열이다.
 * 추가적으로 정렬되어야 할 index 1 원소인 3을 우선 newItem에 저장시킨다.
 * 이후 while문에서 주어진 두번째 조건문인
 *  array[j-1] > newItem  // 현재 삽입될 새로운 원소가 배열의 이전에 위치한 이전 원소보다 작다면,
 *  당연히 이전원소와 새로 삽입된 원소(제일 오른쪽 끝에 있는 원소)와 자리를 바꾸어야한다.
 *  이 과정이 계속 반복된다.
 *  j -=1이되면서, 이전원소의 위치로 newItem이 이동했을 때 또 그 이전 index에 위치한 원소와 크기 비교를 한다. ( array[j -1] > newItem)
 * 또는 언제까지?
 * j >0 일 때까지 반복을 한다. 이때까지 while문이 돌아간 다는 것은 주어진 원소newItem이 크기가 작다는 것이다.
 *  그렇지 않다면 중간에 while 문 두번째 조건문에 의해 break된다.
 *  break를 통해 빠져나온다면 특정 위치 j 에서 array[j-1]의 원소보다 크므로 inedex j 의 자리에 newItem을 삽입한다.
 *
 * @property j
 * 이 프로퍼티는 새로 삽입될 '원소'와, 그 이전원소를 가리킬 때 사용된다.
 * @property newItem
 * 이 프로퍼티는 새로 삽입될 원소의 데이터를 저장한다.
 *      while문 이전에 newItem의 index는 정렬된 배열의 맨 마지막에 위치한다.
 *      이후 while문을 통해 자신의 이전원소보다 작은 원소를 만날 때까지
 *      배열의 맨 마지막까지 위치한 index에서 자신보다 큰 원소가 존재한다면 이전 원소를 현재 위치한 자리에 저장한다.(array[j] = array[j-1])
 *
 * for _ in 1..<array.count {} 에서
 * 1..<array.count이 숫자들은
 * 주어진 배열에서 아직 정렬되지 않는 배열의 원소들을 의미한다.
 * 이 for in 구문이 끝난이후에 주어진 배열은 오름차순으로 정렬 완료 될 것이다.
 */
