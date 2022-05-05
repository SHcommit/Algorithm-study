import Foundation

/**
 *HW 지도의 HW[0]높이, HW[1]넓이 저장
 *isVisited : dfs탐색을 통해 이미 빙산을 탐색했을 경우 true처리
 */
var HW = readLine()!.split(separator:" ").map{Int(String($0))!}
var direction = [(-1,0),(1,0),(0,-1),(0,1)]
var sea = Array(repeating: [Int](), count: HW[0])
var year = 0
for y in 0..<HW[0]{
    sea[y] = readLine()!.split(separator:" ").map{
        Int(String($0))!
    }
}

/**
 * Entry potint <시작점>
 * 빙하가 다 녹을 때 ( 0을 반환할 때까지 ) while문 종료
 * or 그 이전에 빙하가 녹아 특정 년도에 빙하가 2개 이상이 있을 경우 while문 종료
 * 이 두가지 조건중 한개로 무조건 while문은 끝나게 되어 있습니다.
 * ---------------------------------------------------
 * @param : isAllIceBergMelted = 모든 빙산이 녹았는가? 어떻게 확인하지?
 * ==> 빙하가 두개가 있는지 탐색하는 함수 detected(visited:allIceBergMelted:)에서 dfs탐색이 아예 없을 경우 빙하가 다 녹았음을 뜻한다
 *     이 경우 while문 종료
 * @param : isVisited1 = detected함수에서 빙산이 녹았는지 탐색할 때 방문한 빙산을 표시하기 위한 변수
 * @param: isVisited2 = meltIngberg(visited:) 인접한 바다 개수에 따라 빙산을 녹는 작업을 진행 할 때 빙산이 녹았는지 탐색할 때 방문한 빙산을 표시하기 위한 변수
 * // 혹시 isVisited2 = isVisited1로하면 inout에서 메모리 관련 이상한 점이 발생할까봐 그냥 추가로 변수를 할당했습니다.
 * @param : isSeparated = 빙하 탐색을 통해 빙하가 녹아 2개 이상의 구역이 발생했는가? 했으면 true else false
 * 발생했다면, 빙하가 만약 isAllIceBergMelted == true? -> 0 출력
 * 아닐 경우 2개 이상의 빙하지역 발생! break 후 특정 년도 출력
 */
while( true ) {
    var isAllIceBergMelted = false
    var isVisited1 : [[Bool]] = Array(repeating: Array(repeating: false, count: HW[1]), count: HW[0])
    var isVisited2 = isVisited1
    //2개의 구역이 있는가?!
    let isSeparated : Bool = detected(visited: &isVisited1, allIceBergMelted : &isAllIceBergMelted)
    
    if !isSeparated{
        meltIceberg(visited : &isVisited2)
    }else{
        //두개 구역 분리되면 종료 또는 빙하가 자연스래 녹을 경우 0 출력
        if isAllIceBergMelted {
            year = 0
            break
        }else{
            break
            
        }
    }
    year += 1
}
//결과 출력
print(year)
/*
 ----------------------------------------------------------------
 * 여기서부터는 while문에 쓰이는 함수들이 정의되어 있습니다.
 * detected(visited:allIceBergMelted) : 빙하 2개 이상있는지 탐색하는 함수
 * meltIceberg(visited:) 빙하가 녹는 작업 실시!
 * dfs(paramX:paramY:isMelt:visit:) isMelt의 true false여부에 따라 빙하가 녹는작업? or 그냥 빙하가 2개인 구간 detected 탐색 할지 결정됨! - 재귀 사용
 */

//땅이 2개인가? 탐색하는 함수
// 2개이상의 dfs 실행될 경우 true 반환 후 while문 종료, 아니면 meltIceberg()탐사 후 while문 반복
func detected(visited: inout [[Bool]] ,allIceBergMelted iceBerg : inout Bool) -> Bool{
    var dfsTry = 0
    for y in 0..<HW[0]{
        for x in 0..<HW[1]{
            //여기서 방문하지 않은 땅이라면 방문하고 dfs에서 true처리 근데, 만약 땅이 2개라면 dfs 두번 실행되겠지?! 호호,,
            if sea[y][x] != 0 && visited[y][x] == false{
                dfs(paramX: x, paramY: y,isMelt: false,visit: &visited)
                dfsTry += 1
                if dfsTry == 2 {
                    return true
                }
            }
        }
    }
    
    //만약 while도중 빙하가 모두 녹아버렸다면 dfs작업 안 한거니까 return true 후 while문 종료
    if dfsTry == 0 {
        iceBerg = true
        return true
    }
    return false
}

//빙하가 녹아 샤르르~
func meltIceberg(visited: inout [[Bool]]){
    for y in 0..<HW[0]{
        for x in 0..<HW[1]{
            if sea[y][x] != 0{
                dfs(paramX: x, paramY: y,isMelt: true, visit: &visited)
                //빙하는 한 구역밖에 없을 테니 reutrn실시!!
                return
            }
        }
    }
}
/**
 * @param : notIce = 빙하가 아닌 값, 즉 바다인 경우를 세는 변수다.
 * ismalt true면 dfs를 통해 한개의 빙산이 한칸씩 녹음, false면 그냥 탐색만 (2개 dfs되면 2개이상빙하)
 * 맨 처음에 stack을 사용한 dfs를 구현했었는데, 이 경우 약간 구현하기 귀찮? 어려워보여서 재귀 호출로 dfs를 수행하며 해결했다.
 */
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
        //만약 방문하지 않은 빙하이면!!!!!!
        if sea[ny][nx] != 0 && visit[ny][nx] == false{
            visit[ny][nx] = true
            dfs(paramX: nx, paramY: ny, isMelt: isMelt, visit: &visit)
                
        }
    }
    // 위의 포문 (상하좌우) 탐색을 통해 바다인 칸 (notIce)만큼 빼준다.
    if isMelt{
        sea[y][x] -= notIce
        if sea[y][x] < 0 {
            sea[y][x] = 0
        }
    }

}



