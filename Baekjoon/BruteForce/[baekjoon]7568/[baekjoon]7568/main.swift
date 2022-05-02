//  [baekjoon]7568
//  Created by 양승현 on 2022/05/02.
// https://www.acmicpc.net/problem/7568

import Foundation

solution()

func solution(){
    
    var variable = Variable(n: Int(readLine()!)!)
    
    updateList(list: &variable.list, n: variable.n)
    
    bruteForce(rank: &variable.rank, list: variable.list, n: variable.n)
    
    result(rank: variable.rank)
}

/**
 * n = 사람
 * list = 키, 몸무게 동시에 저장하는 배열
 * rank = 덩치 비교
 */
class Variable{
    var n : Int
    var list : [(Int,Int)]
    var rank : [Int]
    
    init(n : Int){
        self.n = n
        self.list = [(Int,Int)]()
        self.rank = Array(repeating: 1, count: n)
    }
    
}

// variable의 멤버변수 list에 키, 몸무게 데이터 추가
func updateList(list : inout [(Int,Int)], n : Int){
    for _ in 0..<n{
        var input = readLine()!.split(separator: " ").map{Int(String($0))!}
        list.append((input[0],input[1]))
    }
}

/**
 * 사람 별로 큰 덩치 순위 비교하는 함수
 * 변수 i 를 통해
 *      list[i] 에서 현재 순위가 매겨질 사람 키( m ) , 몸무게( kg )를 얻어옴
 * 변수 j 를 통해
 *      list[j] 에서 모든 사람 중에서 몇번째 덩치 인지 탐색함 키( tempM ),  몸무게 ( tempKG ) 로 정보 얻어옴
 * 현재 순위가 매겨질 m, kg가 모든 사람중 특정한 사람 tempM, tempKG 보다 덩치가 작을 경우 +1로 덩치 등수가 내려감
 */
func bruteForce(rank : inout [Int], list : [(Int,Int)], n : Int) {
    
    for i in 0..<n{
        
        let (m,kg) = list[i]
        
        for j in 0..<n{
            
            if i == j {
                continue
            }
            
            let (tempM,tempKG) = list[j]
            
            if m < tempM && kg < tempKG {
                rank[i] += 1
            }
            
        }
    }
}

func result(rank : [Int]){
    print( rank.map{String($0)}.joined(separator: " ") )
}
