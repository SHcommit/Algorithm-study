import Foundation

func BFS(_ ABC : [Int])
{
    let maxA    = ABC[0] , maxB = ABC[1] , maxC = ABC[2]
    var queue   = [(0,0,maxC)]
    var index   = 0
    var res     = ""
    var ans     = [Int]()
    var visited = Array(repeating: Array(repeating: Array(repeating: false,count:ABC[2] + 1), count :ABC[1] + 1) , count: ABC[0] + 1)
    visited[0][0][maxC] = true
    
    while queue.count != index
    {
        let (curA,curB,curC) = queue[index]
        index += 1
        if curA == 0
        {
            ans.append(curC)
        }
        // C에서 B에 물을 채우는 경우 . a 는 상관x
        if (curB + curC) > maxB && !visited[curA][maxB][(curB+curC)-maxB]
        {
            visited[curA][maxB][(curB+curC)-maxB] = true
            queue.append((curA,maxB,(curB+curC)-maxB))
        }
        else if curB + curC <= maxB
        {
            if !visited[curA][curB+curC][0]
            {
                visited[curA][curB+curC][0] = true
                queue.append((curA,curB+curC,0))
            }
        }
        // C에서 A에 물을 채우는 경우. B는 상관 x
        if (curA + curC) > maxA && !visited[maxA][curB][(curA+curC) - maxA]
        {
            visited[maxA][curB][(curA+curC)-maxA] = true
            queue.append((maxA,curB,(curA+curC)-maxA))
        }
        else if curA+curC <= maxA
        {
             if !visited[curA+curC][curB][0]
            {
                 visited[curA+curC][curB][0] = true
                 queue.append((curA+curC,curB,0))
            }
        }
        // B에서 A에 물을 채우는 경우. C는 상관 x
        if (curB + curA) > maxA && !visited[maxA][(curB + curA) - maxA][curC]
        {
            visited[maxA][(curB+curA)-maxA][curC] = true
            queue.append((maxA,(curB+curA)-maxA,curC))
        }
        else if curB+curA <= maxA
        {
            if !visited[curA+curB][0][curC]{
                visited[curA+curB][0][curC] = true
                queue.append((curA+curB,0,curC))
            }
        }
        //B에서 C에 물을 채우는 경우. A는 상관x
        if (curB + curC) > maxC && !visited[curA][(curB+curC)-maxC][maxC]
        {
            visited[curA][(curB+curC)-maxC][maxC] = true
            queue.append((curA,(curB+curC)-maxC,maxC))
        }
        else if curB+curB <= maxC
        {
            if !visited[curA][0][curB+curC]
            {
                visited[curA][0][curB+curC] = true
                queue.append((curA,0,curB+curC))
            }
        }
        // A에서 B에 물을 채우는 경우. C는 상관x
        if (curA + curB) > maxB && !visited[(curA+curB)-maxB][maxB][curC]
        {
            visited[(curA+curB)-maxB][maxB][curC] = true
            queue.append(((curA+curB)-maxB,maxB,curC))
        }else if curA + curB <= maxB
        {
            if !visited[0][curA+curB][curC]
            {
                visited[0][curA+curB][curC] = true
                queue.append((0,curA+curB,curC))
            }
        }
        // A에서 C에 물을 채우는 경우. B는 상관x
        if (curA + curC) > maxC && !visited[(curA+curC)-maxC][curB][maxC]
        {
            visited[(curA+curC)-maxC][curB][maxC] = true
            queue.append(((curA+curC)-maxC,curB,maxC))
        }
        else if curA+curC <= maxC
        {
            if !visited[0][curB][curA+curC]
            {
                visited[0][curB][curA+curC] = true
                queue.append((0,curB,curA+curC))
            }
        }
    }
    ans.sort()
    ans.forEach
    {
        res += "\($0) "
    }
    print(res)
}
func BOJ_2251()
{
    var ABC   = readLine()!.split(separator: " ").map{Int(String($0))!}
    BFS(ABC)
}
BOJ_2251()
