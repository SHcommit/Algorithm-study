/*
var HW = readLine()!.split(separator: " ").map{Int(String($0))!}

let direction = [(-1,0),(1,0),(0,1),(0,-1)]
var dish = Array(repeating: [Int](), count: HW[0])
var time = 0
var iceCountPast = 0
var iceCountCurrent = 0
for y in 0..<HW[0]{
    dish[y] = readLine()!.split(separator: " ").map{Int(String($0))!}
}


func checkSealedAir(dish: inout [[Int]], visited : inout [[Bool]])
{
    for y in 0..<HW[0]
    {
        for x in 0..<HW[1]
        {
            if visited[y][x] == false && dish[y][x] == 0{
                var notSealedAir = false
                if time == 0
                {
                    visited[y][x] = true
                    dish[y][x] = -1
                    changeAir(paramX: x, paramY: y, isNotSealed: &notSealedAir, dish: &dish, visited: &visited)
                    return
                }else if time > 0{
                    visited[y][x] = true
                    changeAir(paramX: x, paramY: y, isNotSealed : &notSealedAir, dish: &dish, visited: &visited)
                }
            }
        }
    }
}

func changeAir(paramX x : Int, paramY y : Int, isNotSealed check : inout Bool , dish :inout [[Int]], visited : inout [[Bool]]){

    for (dx,dy) in direction
    {
        let nx = dx + x
        let ny = dy + y
        if nx < 0 || nx > HW[1] - 1  || ny < 0 || ny > HW[0] - 1{
            continue
        }
        if time == 0{
            if visited[ny][nx] == false && dish[ny][nx] == 0 {
                visited[ny][nx] = true
                dish[ny][nx] = -1
                changeAir(paramX: nx, paramY: ny, isNotSealed: &check, dish: &dish, visited: &visited)
            }
        }
        else if time > 0
        {
            if dish[y][x] == 0 && dish[ny][nx] == -1 && visited[ny][nx] == false{
                check = true
            }
            if visited[ny][nx] == false && dish[ny][nx] == 0 {
                visited[ny][nx] = true
                changeAir(paramX: nx, paramY: ny, isNotSealed: &check, dish: &dish, visited: &visited)
            }
        }
    }
    if check == true && time > 0 && dish[y][x] == 0 && visited[y][x] == true{
        dish[y][x] = -1
    }
}

func meltingCheese( dish: inout [[Int]], visited: inout [[Bool]]){
    var contactAir = Array(repeating: Array(repeating: false, count: HW[1]), count: HW[0])
    iceCountCurrent = 0
    for y in 0..<HW[0]{
        for x in 0..<HW[1]{
            if visited[y][x] == false && dish[y][x] == 1{
                visited[y][x] = true
                iceCountCurrent += 1
                dfs(paramX: x, paramY: y, dish: &dish, visited: &visited, contactAir: &contactAir)
            }
        }
    }
    for y in 0..<HW[0]{
        for x in 0..<HW[1]{
            if contactAir[y][x] == true && visited[y][x] == true{
                dish[y][x] = -1
            }
        }
    }
    
}

func dfs(paramX x: Int , paramY y : Int,dish: inout [[Int]], visited : inout [[Bool]] ,contactAir : inout [[Bool]]){
    for (dx,dy) in direction
    {
        let ny = dy + y
        let nx = dx + x
        if nx < 0 || nx > HW[1] - 1  || ny < 0 || ny > HW[0] - 1{
            continue
        }
        if visited[ny][nx] == false && dish[y][x] == 1 {
            if dish[ny][nx] == -1{
                contactAir[y][x] = true
            }
            if dish[ny][nx] == 1{
                iceCountCurrent += 1
                visited[ny][nx] = true
                dfs(paramX: nx, paramY: ny, dish: &dish, visited: &visited, contactAir: &contactAir)
            }
        }
    }
}

while(true){
    var visited1 = Array(repeating: Array(repeating: false, count: HW[1]), count: HW[0])
    var visited2 = Array(repeating: Array(repeating: false, count: HW[1]), count: HW[0])
    iceCountPast = iceCountCurrent
    checkSealedAir(dish : &dish, visited: &visited1)
    meltingCheese(dish: &dish, visited: &visited2)
    if time == 0 && iceCountCurrent == 0{
        iceCountPast = iceCountCurrent
        break;
    }
    if iceCountCurrent == 0{
        break;
    }
    time += 1
}
print(time)
print(iceCountPast)
*/
import Foundation
var HW         = readLine()!.split(separator: " ").map{Int(String($0))!}
var height     = HW[0]
var width      = HW[1]
let direction  = [(-1,0),(1,0),(0,1),(0,-1)]
var map        = Array(repeating: [Int](), count: height)

var curCheese  = 1
var prevCheese = 0

var time       = 0

//????????? dfs 0 ???????????? 0??? ??? ?????? visit true????????? ????????? changeAir??? ?????? 7??? ?????? ???????????????
var visit      = Array(repeating: Array(repeating: false, count: width), count: height)
var needMelt : [[Bool]] = visit
for y in 0..<height{
    map[y] = readLine()!.split(separator: " ").map{Int(String($0))!}
}

// type == 7?????? dfs?????? needChange ,, ????????? ????????? ????????? ??? 7??? ???????????? ???????????????
func changeAir(map : inout [[Int]], visit : inout [[Bool]], type : Int){
    for y in 0..<height{
        for x in 0..<width{
            if ( type == 0 || type == 7 ) && visit[y][x] == true {
                map[y][x] = 7
            }
        }
    }
}
//?????? ????????? melt ?????? changeAir??? ?????? ?????? ???, ??? ?????? 0 ??? 7??? ???????????? 0??? ????????????. ??? ??? 7??? ????????????.
func changeNotSealed(map : inout [[Int]], visit : inout [[Bool]], needChange check : inout [[Bool]]){
    for y in 0..<height{
        for x in 0..<width{
            
            var index = 0
            var isRealNotSealed = false
            //????????? ?????????????????? ????????? 0 ??? ??????????????? 7??? ???????????????? ?????? check true ????????? ?????????????????? true??? ??? 7??? ?????????.
            if map[y][x] == 0 && visit[y][x] == false {
                visit[y][x] = true
                check[y][x] = true
                var stack = [(x,y)]
                //????????? 0 ??????????????? 7??? ???????????? ?????? ?????? ?????? check ?????? ?????? false???????????? ????????? ????????????
                while(stack.count != index){
                    let (curX,curY) = stack[index]
                    for (dx, dy) in direction{
                        let nx = dx + curX
                        let ny = dy + curY
                        if map[ny][nx] == 7 {
                            isRealNotSealed = true
                        }
                        if map[ny][nx] == 0 && visit[ny][nx] == false{
                            visit[ny][nx] = true
                            check[ny][nx] = true
                            stack.append((nx,ny))
                        }
                    }
                    index += 1
                }
                if !isRealNotSealed {
                    for (nx,ny) in stack{
                        check[ny][nx] = false
                    }
                }
            }
        }
    }
    changeAir(map: &map, visit: &check, type: 7)
}

/**
 * ????????? ????????? ???????????? 0 ??? ??????????????? ???????????? ??????,
 * 1????????? 1???????????? ??????! ?????? ?????? ?????? ??????
 * 7??? ?????? ?????? ?????? ???????????? ?????? .?????? ????????? ??????,, ??????????????? -1??? ????????? ????????? needChange??? check??? ????????? ????????????.
 */

func dfs(x : Int, y : Int, map : inout [[Int]], visit : inout [[Bool]], needMelt check :inout [[Bool]], type : Int){
    
    for (dx,dy) in direction{
        let nx = dx + x
        let ny = dy + y
        if nx < 0 || nx > width - 1 || ny < 0 || ny > height - 1 {
            continue
        }
        //??? ????????? ??? ????????? 7??? ????????? ????????? ???????????? ?????????,,
        if type == 0{
            if map[ny][nx] == type && visit[ny][nx] == false {
                visit[ny][nx] = true
                dfs(x: nx, y: ny, map: &map, visit: &visit,needMelt: &check ,type: type )
            }
        }else{
            //??? ????????? ??????????????????,, ??????????????? ????????? ???????????? ????????? ??? ???????????? check??????
           // if type == 7 && map[ny][nx] == type  {
             //   check[y][x] = true
                
//            }
            // ??? ????????? ?????? ??????  type == 7 ?????? ??? ?????? 1??? ????????? ??? ???????????? ?????????.
            if visit[ny][nx] == false {
                if map[ny][nx] == 7 {
                    check[y][x] = true
                }
                if map[ny][nx] == 1 {
                    visit[ny][nx] = true
                    curCheese += 1
                    dfs(x: nx, y: ny, map: &map, visit: &visit, needMelt: &check, type: type)
                }
            }
            
            
            //if map[ny][nx] == 1 && visit[ny][nx] == false{
               // visit[ny][nx] = true
               // curCheese += 1
                //dfs(x: nx, y: ny, map: &map, visit: &visit, needMelt: &check, type: type )
            //}
        }

    }
}
//????????? ?????? type ??? 7????????????
func melt(map : inout [[Int]], visit : inout [[Bool]], needMelt check : inout [[Bool]],type : Int){
    curCheese = 0
    for y in 0..<height{
        for x in 0..<width{
            if map[y][x] == 1 && visit[y][x] == false {
                visit[y][x] = true
                curCheese += 1
                dfs(x: x, y: y, map: &map, visit: &visit, needMelt: &check, type: type)
            }
        }
    }
    changeAir(map: &map, visit: &check, type: type)
}


func isNotMap(nx : Int, ny : Int) -> Bool{
    if nx < 0 || nx > width - 1 || ny < 0 || ny > height - 1 {
        return true
    }else {return false}
}

func test(map : inout [[Int]]){
    print()
    for y in 0..<height{
        var res = ""
        for x in 0..<width{
            res += "\(map[y][x]) "
        }
        print(res)
    }
}
func test2(visit : [[Bool]]){
    print()
    for y in 0..<height{
        var res = ""
        for x in 0..<width{
            res += "\(visit[y][x]) "
        }
        print(res)
    }
    print()
}
func resetVisit(visit : inout [[Bool]], needMelt : inout [[Bool]]){
    visit = Array(repeating: Array(repeating: false, count: width), count: height)
    needMelt = visit
}

visit[0][0] = true
dfs(x: 0, y : 0, map : &map, visit : &visit, needMelt: &needMelt ,type : 0)
changeAir(map: &map, visit: &visit, type : 0)

//???????????? curCheese 58
//1 melt 2 changeAir 3.changeNOtSealed
while(true){
    
    prevCheese = curCheese
    resetVisit(visit: &visit, needMelt: &needMelt)
    melt(map: &map, visit: &visit, needMelt: &needMelt, type: 7)
    resetVisit(visit: &visit, needMelt: &needMelt)
    changeNotSealed(map: &map, visit: &visit, needChange: &needMelt)
    if curCheese == 0 {
        break
    }
    time += 1
    
}

print(time)
print(prevCheese)
