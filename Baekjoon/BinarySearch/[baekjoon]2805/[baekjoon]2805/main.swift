/**
 *  나무 m 미터가 필요해
 *  목제 절단기는 높이를 예를들어 15로 설정하면 ( 0~ 양의 정수 설정 가능)
 *  나무들이 20 15 10 17 있는데, 15 15 10 15 로 되고 바닥에 나무가 5,2 -> 7 떨어진다.
 * 필요한 만큼만 나무 가져가, 적어도 M민터 나무 집에 가져가기 위해
 * 설정할 수 있는 높이의 최댓값을 구하는 프로그램 짜봐
 *input 1 = 나무 수 , 2 = 집에 가져가기 위한 m인데 항상 m보다 크거나 같음.
 * 적어도 m 미터 이상 집에 가져가ㅣ 위해 절단기에 설정할 수 있는 높이의 최대값을 구해라
 *
 * -> 결정문제 : 다시말해 m미터가 되는 절단기의 높이는 몇인가?
 */
import Foundation
/**
 * 내가 틀렸던 이유가 난그냥 트리 한개일때 그 높이가 최소 가져가야하는 높이일경우와 같을때
 * 만약에 트리가 딱 한개인경우로만 한정했는데 (tree[0] 그게 아니라 tree[3] 일때는
 * 적합한 mid 를 못구해서 그냥 초기화된 answer 출력되는데. 그게 1이었음,, 그걸 0으로했으면 맞았던문제
 * 6 1
 * 0 0 0 1 0 0
 */
var input = readLine()!.split(separator: " ").map{Int(String($0))!}
//나무 개수 1~ 1,000,000
var n = input[0]
//집에 가져갈 최소한의 나무 크기 1 ≤ M ≤ 2,000,000,000!!
var m = input[1]
var maxTreeHeight = 0
var tree : [Int] = readLine()!.split(separator: " ").map{
    let temp = Int($0)!
        if (temp > maxTreeHeight){
            maxTreeHeight = temp
        }
    return temp
}

/**
 
 아하 right을 tree에서 제일 큰 거로 지정하면됌
6 1
0 1 0 0 0 0
 */

//높이를 구해야해 1~~~ 1000000 -> r
// 높이를 이분탐색으로 구할거임
func binary_search(){
    var answer = 0
    var left = 1
    var right = maxTreeHeight
        //아하 미드 없으면 그냥 answer 0으로
    /*if tree.count == 1 && tree[0] == m{
        print(0)
        return
    }*/
    var mid : Int
    while(left <= right){
        mid = (left + right) / 2
        if (isSuitableTreeCut(treeHeight: mid)){
            answer = mid
            left = mid + 1
        }else{
            right = mid - 1
        }
    }
    print(answer)
}
func isSuitableTreeCut(treeHeight height: Int) -> Bool{
    var cuttedTree = 0
    for i in 0..<tree.count{
        if tree[i] >= height {
            cuttedTree += tree[i] - height
        }
    }
    if cuttedTree >= m {
        return true
    }else {
        return false
    }
}

binary_search()
