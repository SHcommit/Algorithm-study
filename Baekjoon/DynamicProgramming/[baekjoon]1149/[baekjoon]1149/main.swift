import Foundation
/*
 RGB거리 집이 N개.1번 ~ N번 집이 순서대로.
 집은 R, G, B중 1개의 색으로 칠해져야 함 이때 각각의 색에 따라 비용이 주어진다
 
  아래 규칙을 만족 + 모든 집을 칠하는 비용의 최솟값을 구해보자.

 1번 집의 색은 2번 집의 색과 같지 않아야 한다.
 N번 집의 색은 N-1번 집의 색과 같지 않아야 한다.
 i(2 ≤ i ≤ N-1)번 집의 색은 i-1번, i+1번 집의 색과 같지 않아야 한다.
 입력
 첫째 줄에 집의 수 N(2 ≤ N ≤ 1,000)이 주어진다. 둘째 줄부터 N개의 줄에는 각 집을 빨강, 초록, 파랑으로 칠하는 비용이 1번 집부터 한 줄에 하나씩 주어진다. 집을 칠하는 비용은 1,000보다 작거나 같은 자연수이다.
 */

//집마다 위의 조건을 만족하면서 칠할 수 있는 비용을 최소를 만족시키도록 집을 칠해야 한다.
//조건은
//1번집은 2번집의 색과 달라야함... N번집은 n-1번 집과 색이 달라야해!!
//1번이 빨강이면 2번은 G, B 이때 2번이 G면 3번은 R 아니면 B근데 여기서 마지막 조건에의해 무조건 색은 1개

//1번에 따라서 색이 정해질수밖에없음
//1번의 색 정할 수 있는방법 3개 -> 2번은 그거 제외한 2개 그담부턴 쭉 일정
func dynamicProgramming(n : Int, house : inout [[Int]],dp : inout [Int]){
    dp[1]
}
func BOJ_1149(){
    let n     = Int(readLine()!)!
    var house = Array(repeating: [Int](), count: n)
    var dp    = Array(repeating: 1000, count: n)
    for i in 0..<n{
        house[i] = readLine()!.split(separator: " ").map{Int(String($0))!}
    }
    dynamicProgramming(n: n, house: &house, dp: &dp)
}

BOJ_1149()
