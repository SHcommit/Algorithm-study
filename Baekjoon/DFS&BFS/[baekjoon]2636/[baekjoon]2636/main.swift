import Foundation

var HW = readLine()!.split(separator: " ").map{Int(String($0))!}
let dx = [-1,1,0,0]
let dy = [0,0,1,-1]
//let direction = [(-1,0),(1,0),(0,1),(0,-1)]
var dish = Array(repeating: [Int](), count: HW[0])
var time = 0
var iceCountPast = 100
var iceCountCurrent = 100
//처음 밀폐공간은 반드시 실행 이후 있나없나 탐색후 해당함수 실행할지말지 결정됨
var isSealedAir = true
for y in 0..<HW[0]{
    dish[y] = readLine()!.split(separator: " ").map{Int(String($0))!}
}

func curIceState(dish : inout [[Int]],visitC : inout[[Bool]]){
    iceCountCurrent = 0
    for y in 0..<HW[0]{
        for x in 0..<HW[1]{
            if visitC[y][x] == false && dish[y][x] == 1{
                var queue = [(x,y)]
                while(!queue.isEmpty){
                    let (x, y) = queue.removeLast()
                    //for (dx, dy) in direction{
                    for i in 0..<dx.count{
                        let nx = dx[i] + x
                        let ny = dy[i] + y
                        if nx < 0 || nx > HW[0] - 1 || ny < 0 || ny > HW[1] - 1 {
                            continue
                        }
                        if visitC[ny][nx] == false && dish[ny][nx] == 1{
                            iceCountCurrent += 1
                            visitC[ny][nx] = true
                            queue.append((nx,ny))
                        }
                    }
                }
                
            }
        }
    }
}

/**
 * @param : duration = 치즈 녹는 시간
 * @param :dish = 맵
 *함수명 밀폐된 공기!! 일단 dTime == 0일때는 무조건 있으니까
 *dTime == 0일때 우선 바깥공기 -1으로만들고
 *1일때부터는 바깥공기로인해 내부 밀폐된 공기 접촉됬나 확인만.
 *만약 아직 바깥공기 -1과 내부공기 0 인접안하면 return true
 *밀접할경우 밀폐공기도 0만들고, reurn false!!
 *------------------------------
 * dTime == 0일때
 * 맨첨에 0이면 접시부분들 그냥 싹다 -1로 만들자
 * 그리고 바로 true 반환하자. 어차피 0은 무조건 공기고 이때 바깥 공기를 -1로 바꾸자
 * ----------------
 * dTime == 1이상일때, 밀폐공기 0 이 있는지 확인후 있으면 true반환
 * 없을시 false반환하는데, 이후부턴 sealedAir 실행안됨retu
 */
func sealedAir(duration dTime : inout Int,dish map: inout [[Int]], visitedCheese visitC: inout [[Bool]]) -> Bool
{
    //반환될거, 이거 true면 밀폐된거 있는거
    var isSealed = true
    for y in 0..<HW[0]
    {
        for x in 0..<HW[1]
        {
            if visitC[y][x] == false && map[y][x] == 0
            {
                var tempCheckedSealedAir = false
                if dTime == 0
                {
                    visitC[y][x] = true
                    map[y][x] = -1
                    dfsForDetectedSealedAir(paramX: x, paramY: y, duration: dTime,isNotSealed: &isSealed, dish: &map, visitedCheese: &visitC)
                    return true
                }else if dTime > 0{
                    visitC[y][x] = true
                    dfsForDetectedSealedAir(paramX: x, paramY: y, duration: dTime,isNotSealed : &tempCheckedSealedAir, dish: &map, visitedCheese: &visitC)
                    //밀봉된 공기가 적어도 하나라도 있다면 결과는 반환하고, -1과 인접한 0은 계속해서 찾아서 -1로 치환!
                    if tempCheckedSealedAir == true {
                        isSealed = true
                    }
                }
            }
        }
    }
    if isSealed == true{
        return true
    }else{
        return false
    }
}

//여기선 그냥 밀폐탐색하고, ,만약 -1 과 0 겹치면 그거바꾸고 isSealedAir == false 처리 전까지 수행해주는 함수,,
func dfsForDetectedSealedAir(paramX x : Int, paramY y : Int, duration dTime : Int, isNotSealed check : inout Bool , dish map : inout [[Int]], visitedCheese visitC : inout [[Bool]]){
    
    //만약 여기서 tempCheckSealedAir 가 true가 된다면 무조건 밀폐된 공간이 있는거임
    for i in 0..<dx.count
    {
        let nx = dx[i] + x
        let ny = dy[i] + y
        if nx < 0 || nx > HW[1] - 1  || ny < 0 || ny > HW[0] - 1{
            continue
        }
        //이게 실행되지 않는다면, 아직 밀폐된공기가 있는 것 밀폐공기가 아니니까 false로 !!
        if map[y][x] == 0 && map[ny][nx] == -1 {
            check = false
        }
        if dTime == 0{
            if visitC[ny][nx] == false && map[ny][nx] == 0 {
                visitC[ny][nx] = true
                map[ny][nx] = -1
                dfsForDetectedSealedAir(paramX: nx, paramY: ny, duration: dTime, isNotSealed: &check, dish: &map, visitedCheese: &visitC)
            }
        }
        // 넌 0만 탐색해라~~ 근데 탐색할때 그 그 탐색대상이 현 좌표가 되는데,
        // -1 과 0일경우 check true로 해라.
        else if dTime > 0 {
            if visitC[ny][nx] == false && map[ny][nx] == 0 {
                visitC[ny][nx] = true
                dfsForDetectedSealedAir(paramX: nx, paramY: ny, duration: dTime, isNotSealed: &check, dish: &map, visitedCheese: &visitC)
            }
        }
        
    }
    if check == false && dTime > 0 && map[y][x] == 0{
        map[y][x] = -1
    }
}




/**
 * 여기선 치즈 녹는작업 실시
 * 바깥인지 어떻게 확인?
 * map == 1의 상하좌우중에 -1있으면 ,, + 동시에 치즈 녹아내려야 햄
 */
func meltingCheese(duration dTime : inout Int, dish map: inout [[Int]], visitedCheese visitC: inout [[Bool]]){
    for y in 0..<HW[0]{
        for x in 0..<HW[1]{
            if visitC[y][x] == false && map[y][x] == 1{
                dfs(paramX: x, paramY: y, dish: &map, visitedCheese: &visitC)
            }
        }
    }
}

/**
 * @param : paramX , paramY = 현재 탐색될 x,y 좌표
 * @param : duration = 치즈 녹는 기간
 * @param : dish == map
 * @param : visitedCheese 방문탐색 체크
 */
func dfs(paramX x: Int , paramY y : Int,dish map : inout [[Int]], visitedCheese visitC : inout [[Bool]]){
   // for (dy,dx) in direction{
    //한개라도 -1 있다면 탐색구나에 true로 바꾸고, 해당 x,y는 -1처리
    var melting = false
    for i in 0..<dx.count
    {
        
        let ny = dy[i] + y
        let nx = dx[i] + x
        
        if nx < 0 || nx > HW[0] - 1  || ny < 0 || ny > HW[1] - 1{
            continue
        }
        if visitC[ny][nx] == false && map[y][x] == 1 && map[ny][nx] == -1 {
            melting = true
            visitC[ny][nx] = true
            dfs(paramX: nx, paramY: ny, dish: &map, visitedCheese: &visitC)
        }
    }
    if  map[y][x] == 1 && melting == true{
        map[y][x] = -1
    }
}


//entry point
while(true){
    
    var visitedCheese1 = Array(repeating: Array(repeating: false, count: HW[1]), count: HW[0])
    var visitedCheese2 = Array(repeating: Array(repeating: false, count: HW[1]), count: HW[0])
    var visitedCheese3 = Array(repeating: Array(repeating: false, count: HW[1]), count: HW[0])
    
    if isSealedAir {
        //근데 밀폐공간 한개라도 있으면,,? true반환,,
        isSealedAir = sealedAir(duration: &time, dish : &dish,visitedCheese: &visitedCheese1)
    }
    //0일 땐 얼음 안녹아
    curIceState(dish: &dish, visitC :&visitedCheese3)
    meltingCheese(duration: &time, dish: &dish, visitedCheese: &visitedCheese2)
    time += 1
    if iceCountCurrent == 0{
        break;
    }
    iceCountPast = iceCountCurrent
    
}

print("\(time)\n\(iceCountPast)")
