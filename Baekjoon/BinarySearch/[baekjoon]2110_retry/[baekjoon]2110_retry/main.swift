//https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-2110-%EA%B3%B5%EC%9C%A0%EA%B8%B0-%EC%84%A4%EC%B9%98
import Foundation

// 이때의 mid는 가장 인접한 두 집 사이의 공유기 거리 입니다.
func binary_search(house : [Int], installRouter C : Int) -> Int{
    var answer = 1
    var left   = 1
    var right  = 1000000000
    
    while(left <= right){
        let mid = (left + right) / 2
        if isInstall(width: mid,installRouter: C,house: house) {
            //주의 해야 할 곳
            if mid > answer{
                answer = mid
            }
            left  = mid + 1
        }else{
            right = mid - 1
        }
    }
    return answer
}

func isInstall(width w: Int,installRouter C : Int,house h : [Int]) -> Bool{
    var install      = 1
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

func BOJ_2110(){
    var NC    = readLine()!.split(separator: " ").map{Int(String($0))!}
    var N     = NC[0]
    var C     = NC[1]
    var house = [Int]()
    
    for i in 0..<N{
        house.append(Int(readLine()!)!)
    }
    house.sort(by: <)
    var answer = binary_search(house: house, installRouter: C)
    print(answer)
}

BOJ_2110()
