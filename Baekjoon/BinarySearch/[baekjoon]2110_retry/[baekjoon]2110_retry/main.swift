/**
 * 집 N개 수직선에있음
 * 수직선 1~  1,000,000,000
 * 집 한개마다 공유기 설치하려함
 * 이때 가장!! 인접한 두 공유기 사이의  거리를 가능한 크게 하여 설치 하는게 문제임.
 
 입력
 첫번째 집 N 두번째 공유기 설치 개수
 5 3
 1
 2
 8
 4
 9
 
 */

import Foundation

func BOJ_2110(){
    var NC = readLine()!.split(separator: " ").map{Int(String($0))!}
    var house = [Int]()
    
    var N = NC[0]
    var C = NC[1]
    for i in 0..<N{
        house.append(Int(readLine()!)!)
    }
    house.sort(by: <)
    var answer = binary_search(house: house, installRouter: C)
    print(answer)
}

/**
 * 여기서 mid는 가장 인접한 두 집 사이의 라우터 설치 m임...
 */
func binary_search(house : [Int], installRouter C : Int) -> Int{
    var answer = 1
    var left = 1
    var right = 1000000000
    
    while(left <= right){
        let mid = (left + right) / 2
        if isInstall(width: mid,installRouter: C,house: house) {
            // 중요!! 가능한 큰거 출력하는거니까
            if mid > answer{
                answer = mid
            }
            //이게 답일경우에는 해당 미터에서는 c개의 라우터가 설치되는거니까
            //미터를 줄여서 도 c개의 라우터가 나오는지 탐색하면됨
            left = mid + 1
        }else{
            right = mid - 1
        }
    }
    return answer
}
//아 left == 1로해야함,,
//여기서 라우터를 길이에 맞게 설치하는 방법은
//일단 house[0]은 무저건 설치!! 그후에
//house[i] - house[i-1]이 라우트 설치간격을 넘는가? 설치됨,, 그럼 이제 설치된게 house[i-1]이됨..
func isInstall(width w: Int,installRouter C : Int,house h : [Int]) -> Bool{
    var install = 1
    var installCoord = h[0]
    for x in 1..<h.count{
        if h[x] - installCoord  >= w{
            installCoord = h[x]
            install += 1
        }
    }
    
    if install >= C {return true}
    else {return false}
}

BOJ_2110()
