import Foundation
/*
 크으.. 대단하네
 dp로는 풀수없는 이유가 수열의 크기가 백만이 넘는다.
 따라서 o(n*n)으로는 1초 내에 풀 수 없다.
 기본적으로 dp를 언제쓰냐면 특정 길이를 저장 해 갈 때 쓰는데 새로운 것이 최장 증가 부분수열인지
 탐색하기 위해서는 이전에 저장된 dp를 활용할 경우 시간이 단축되지만 O(n^2)이다.
 
 그럼 어째.. n * logn 시간으로 단축시킬 수 있도록 이진 탐색을 도입한다. 왜 어떻게??
 dp는 사용하지 않는다. 대신 가장 긴 증가하는 부분 수열을 바로바로 구해간다. 이게 뽀인트인거같다.
 이 수열들은 정렬되있고 중첩이 없다. 이 점을 이용한 것이다.. 대박이다 진짜로..
 */
func binarySearch(_ target : Int,_ sequence : inout [Int])
{
    var left = 0 , right = sequence.count - 1
    var mid  = 0
    while(left < right)
    {
        mid = (left+right)/2
        if target > sequence[mid]
        {
            left = mid + 1
        }
        else
        {
            right = mid
        }
    }
    sequence[right] = target
}
func BOJ_12015()
{
    let n   = Int(readLine()!)!
    var arr = readLine()!.split(separator:" ").map{Int(String($0))!}
    var sequence = [arr[0]]
    
    for i in 1..<n
    {
        if arr[i] > sequence.last!
        {
            sequence.append(arr[i])
        }
        else
        {
            binarySearch(arr[i], &sequence)
        }
    }
    print(sequence.count)
}
BOJ_12015()
