/**
 * 도현이의 집 n개는 수직선 위치에 있음
 * 각각의 집 좌표는 X1 X2... Xn임.
 * 집에 공유기 C 설치하려함. 한 집에는 한개의 공유기만 가능
 *
 * 가장 인접한 두 공유기 사이의 거리 가능한 크게 한 후 설치하려고 함
 *
 * C개의 공유기를 n개의 집에 설치하여, 가장 인접한 두 공유기 사이의 거리를 최대로 하는 프로그램

 * 여러 공유기가 있는데, 이 중 가장 인접한 두 공유기의 거리가 최대인 경우!!! 구하는거!!
 * -------------------------------------------------------
 * 중요한 것은 인접한 두 공유기의 거리가 최대인 경우를 구하는거니까
 *  결정문제로 바꾼다면. 특정한 높이일때 두 공유기는 설치가 되는가? + 몇개까지 설치가 되는가?
 *  이때, 설치가 될 때 마지막까지 설치한 공유기가 원하는 설치 공유기 개수보다 적다면,
 *  그 설치된 두 공유기 간 거리는 큰 것이므로 mid를 줄인다!
 */
import Foundation

var input = readLine()!.split(separator: " ").map{Int(String($0))!}
// 집 개수
var N = input[0]
//공유기 개수
var C = input[1]
var house = [Int]()

for _ in 0..<N{
    house.append(Int(readLine()!)!)
}
//이분탐색을 위해서 정렬은 필수
house.sort()
//left 를 1로 잡았는데,
/**
5 3
100
101
102
103
104
 이 경우 최소 거리가 100 이하로 떨어지지 않아 값을 찾을 수 없다...
 -출처 https://velog.io/@kimdukbae/BOJ-2110-%EA%B3%B5%EC%9C%A0%EA%B8%B0-%EC%84%A4%EC%B9%98-Python-
 */
func binary_search(){
    var left = 1
    var right = house[house.count - 1] - house[0]
    var mid : Int
    var res = 1
    while( left <= right){
        mid = (left + right) / 2
        if isInstall(distance: mid){
            if mid > res{
                res = mid
            }
            left = mid + 1
        }else{
            right = mid - 1
        }
    }
    print(res)
}


func isInstall(distance dist: Int) -> Bool {
    
    var prevInstalled = house[0]
    
    var installed = 1
    for i in 1..<house.count{
        if ( house[i] - prevInstalled ) >= dist {
            prevInstalled = house[i]
            installed += 1
        }
    }
    //3개 설치하나 4개설치하나 어차피 그 1개 빼면됨, 원래 공유기가 3개 설치된다고하면,
    // 특정 거리간격으로 설치 시 4개 까지 설치가 된다 한들 ok임 왜냐 결과 때 그 거리중 한개 빼도 ok니까!!
    if installed >= C{
        return true
    }else{
        return false
    }
}

binary_search()

