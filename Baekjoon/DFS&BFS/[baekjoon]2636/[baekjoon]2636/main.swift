import Foundation

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
