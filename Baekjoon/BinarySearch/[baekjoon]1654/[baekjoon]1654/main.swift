/**
 * N개의 랜선을 만들어야 한다. ( 성원이 )
 * N개의 길이는 모두 같은 크기로 자르길 원한다.
 *
 * 영식이는 K개의 랜선을 갖고 있다. 이때 크기는 제각각
 * <이미 자른 랜선은 붙일 수 없어>
 * K 는 바로 N개의 랜선 될 수 없어
 * 랜선 자를 때 센티미터 단위(정수)로 잘라야함.
 * N개 이상으로 만드는 것도 N에 포함된다.
 * 이때 만들 수 있는 최대 랜선의 길이 구해라
 *
 input
 4 11       //  K 가지고있는거, N 필요한거.    | K는 1~ 10,000 N은1 ~ 1,000,000 이때 항상 k<= N
 802
 743
 457
 539
 */

import Foundation

func binary_search(list : [Int], minCnt : Int){
    var left = 1
    var right = list[list.count - 1]
    var mid : Int
    var ans = 0
    while(left <= right){
        mid = (left + right) / 2
        if cutRope(length: mid,minCnt: minCnt,list: list){
            left = mid + 1
            ans = mid
        }else{
            right = mid - 1
        }
    }
    print(ans)
}

func cutRope(length : Int, minCnt: Int, list : [Int]) -> Bool {
    var cnt = 0
    for i in 0..<list.count{
        cnt += list[i] / length
    }
    if cnt >= minCnt {
        return true
    }else { return false }
}

func BOJ_1654(){
    var KN = readLine()!.split(separator: " ").map{Int(String($0))!}
    var K  = KN[0] // 영식이가 가지고있는거
    var N  = KN[1] // 필요한 랜선 개수
    var arr = [Int]()

    for i in 0..<K{
        arr.append(Int(readLine()!)!)
    }
    arr.sort()
    binary_search(list: arr, minCnt: N)
}

BOJ_1654()
