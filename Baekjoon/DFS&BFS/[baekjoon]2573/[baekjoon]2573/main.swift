import Foundation
//아 문제 잘못읽음

/**
 *HW 지도의 높이, 넓이 저장
 *isVisited : dfs탐색을 통해 바다를 탐색할 때 탐색했을 때 T표시
 *maxYear 까지 year를 증가시키면서 year가 7일 때, 그리고 두 영역으로 나누어지지 않았다면 0 반환*
 */
var HW = readLine()!.split(separator:" ").map{Int(String($0))!}
var direction = [(-1,0),(1,0),(0,-1),(0,1)]
var sea = Array(repeating: [Int](), count: HW[0])
var year = 0
// 바다에 빙하 정보 표시하고 maxYear 탐색
for y in 0..<HW[0]{
    sea[y] = readLine()!.split(separator:" ").map{
        Int(String($0))!
    }
}

//enyty point
// 빙하가 다 녹을 때까지, 그 이전에 2개 구역이 있는지 탐색 하는 반복문
while( true ) {
    var isAllIceBregMelted = false
    var isVisited1 : [[Bool]] = Array(repeating: Array(repeating: false, count: HW[1]), count: HW[0])
    var isVisited2 = isVisited1
    //2개의 구역이 있는가?!
    let isSeparated : Bool = detected(visited: &isVisited1, allIceBergMelted : &isAllIceBregMelted)
    
    if !isSeparated{
        meltIceberg(visited : &isVisited2)
    }else{
        //두개 구역 분리되면 종료 또는 빙하가 자연스레 ㄴ녹을 경우엔 0 출력
        if isAllIceBregMelted {
            year = 0
            break
        }else{
            break
            
        }
    }
    year += 1
    //print()
    //for y in 0..<HW[0]{
      //  print(sea[y].map{String($0)}.joined(separator: " "))
    //}

    
}

print(year)

//땅이 2개인가? 탐색하는 함수
// 2개 true -> 반환 후 while문 종료, 아니면 meltIceberg()탐사 후 detected 반복 maxYear까지
func detected(visited: inout [[Bool]] ,allIceBergMelted iceBerg : inout Bool) -> Bool{
    var dfsTry = 0
    for y in 0..<HW[0]{
        for x in 0..<HW[1]{
            //여기서 방문하지 않은 땅이라면 방문하고 dfs에서 true처리 근데, 만약 땅이 2개라면 dfs 두번 실행되겠지
            if sea[y][x] != 0 && visited[y][x] == false{
                dfs(paramX: x, paramY: y,isMelt: false,visit: &visited)
                dfsTry += 1
                if dfsTry == 2 {
                    return true
                }
            }
        }
    }
    //만약 while도중 빙하가 모두 녹아버렸다면 return true 후 while문 종료
    if dfsTry == 0 {
        iceBerg = true
        return true
    }
    return false
}

//빙하가 녹아
func meltIceberg(visited: inout [[Bool]]){
    for y in 0..<HW[0]{
        for x in 0..<HW[1]{
            if sea[y][x] != 0{
                dfs(paramX: x, paramY: y,isMelt: true, visit: &visited)
                //빙하는 한 구역밖에 없으니까
                return
            }
        }
    }
}

//ismalt true면 dfs를 통해 한개의 빙산이 한칸씩 녹음, false면 그냥 탐색만 (2개 dfs되면 2개이상빙하)
//만약  isMel 작업할 때 빙하가 녹으면 iceberg의 정보를 실시간 업데이트!
//각 year 마다 iceberg를 복사 한 isVisited를 통해 땅이 2개인지 구별할거임
func dfs(paramX x :Int,paramY y :Int,isMelt : Bool, visit : inout [[Bool]]){
    var notIce = 0
    visit[y][x] = true

    notIce = 0
    for (dx,dy) in direction{
        let nx = dx + x
        let ny = dy + y
        if nx < 0 || nx > HW[1] - 1 || ny < 0 || ny > HW[0] - 1{
            continue
        }
        if sea[ny][nx] == 0 && isMelt{
            //빙하가 동시에 녹기위한 조건! 탐색안한 구간에 대해 notIce를 증가시킨다.
            if visit[ny][nx] == false{
                notIce += 1
            }
            
        }
        if sea[ny][nx] != 0 && visit[ny][nx] == false{
            visit[ny][nx] = true
            dfs(paramX: nx, paramY: ny, isMelt: isMelt, visit: &visit)
                
        }
    }
    if isMelt{
        sea[y][x] -= notIce
        if sea[y][x] < 0 {
            sea[y][x] = 0
        }
    }

}



