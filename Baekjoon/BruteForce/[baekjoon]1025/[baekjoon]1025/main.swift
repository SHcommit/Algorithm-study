import Foundation
//https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-1025-%EC%A0%9C%EA%B3%B1%EC%88%98-%EC%B0%BE%EA%B8%B0-%EB%AC%B8%EC%A0%9C-%EB%BF%8C%EC%88%98%EA%B8%B0
func BOJ_1025()
{
    let rect   = readLine()!.split(separator:" ").map{Int($0)!}
    let height = rect[0]
    let width  = rect[1]
    var map    = Array(repeating:[String](),count: height)
    var res    = -1
    for i in 0..<height
    {
        map[i] = readLine()!.map{String($0)}
    }
    /*
      여기서 생성되는 (x,y)좌표는 그림3에서 빨간색 점 부터~ 초록색점 ~ 맨 끝 (4,4)의 점까지 탐색하기
      위한 2중 포문이다. 즉 이 포문을 통해 (0,0) 일 때 나올 수 있는 모든 정수들 중 완전 제곱수(최대값을 갖는 제곱수)를 찾는 즉시 갱신해 갈 것이다.
     */
    for y in 0..<height
    {
        for x in 0..<width
        {
            /*
              여기서 나올수 있는 공차를 구해야한다. 이때 주의할 점이
             N M 행열의 좌표들은 양수이다.
             따라서 특정한 좌표에 연속적인 등차수열을 구하기 위해 각각의 행 열에 공차를 더할 때
             그 행, 열의 좌표가 음수이면 탐색을 못하도록 while문에 조건을 달아야한다!!
             */
            for dy in (-(height-1))..<height
            {
                for dx in (-(width-1))..<width
                {
                    var curX = x
                    var curY = y
                    var sum    = 0
                    var strSum = ""
                    while (curX >= 0 && curX < width) && ( curY >= 0 && curY < height)
                    {
                        strSum += map[curY][curX]
                        sum    = Int(strSum)!
                        var sqrtNum = Int(sqrt(Double(sum)))
                        if sqrtNum*sqrtNum == sum
                        {
                            res = max(res, sum)
                        }
                        if dx == 0 && dy == 0
                        {
                            break
                        }
                        curX = curX + dx
                        curY = curY + dy
                    }
                }
            }
        }
    }
    print(res)
}
BOJ_1025()
