//  main.swift
//  [baekjoon]14502
//  Created by 양승현 on 2022/03/30.

import Foundation

class point
{
    var x : Int
    var y : Int
    init(_ x: Int, _ y : Int)
    {
        self.x = x
        self.y = y
    }
}
class pointCluster
{
    var point : [point]
    init(_ p1 : point, _ p2 : point, _ p3 : point)
    {
        point = [p1]
        point.append(p2)
        point.append(p3)
    }
}
func isOutOfEdge(_ x : Int, _ y : Int, _ width: Int, _ height : Int, _ map : [[Int]]) -> Bool
{
    if x < 0 || x > width - 1 || y < 0 || y > height - 1
    {
        return true
    }
    return false
}
func virus(width : Int, height : Int, pArray : pointCluster, map : [[Int]]) -> Int
{
    var testMap         = map
    var visited         = Array(repeating: Array(repeating: false, count: width), count: height)
    testMap[pArray.point[0].y][pArray.point[0].x] = 1
    testMap[pArray.point[1].y][pArray.point[1].x] = 1
    testMap[pArray.point[2].y][pArray.point[2].x] = 1
    for y in 0..<height
    {
        for x in 0..<width
        {
            if testMap[y][x] == 2 && visited[y][x] == false
            {
                visited[y][x] = true
                spreadVirus(x: x, y: y, width: width, height: height, map: &testMap, visit: &visited)
            }
        }
    }
    return SaveArea(width: width, height: height, map: testMap)
}
func spreadVirus(x : Int, y : Int, width : Int , height : Int, map : inout [[Int]], visit : inout [[Bool]])
{
    var queue     = [(x,y)]
    var direction = [(-1,0),(1,0),(0,1),(0,-1)]
    var index     = 0
    while queue.count != index
    {
        let (curX,curY) = queue[index]
        index += 1
        
        for (dx,dy) in direction
        {
            let (nx,ny) = (curX + dx, curY + dy)
            if isOutOfEdge(nx, ny, width, height, map)
            {
                continue
            }
            if map[ny][nx] == 0 && visit[ny][nx] == false
            {
                queue.append((nx,ny))
                map[ny][nx] = 2
                visit[ny][nx] = true
            }
        }
    }
}
func SaveArea(width : Int, height : Int, map : [[Int]]) -> Int
{
    var count = 0
    for y in 0..<height
    {
        for x in 0..<width
        {
            if map[y][x] == 0
            {
                count += 1
            }
        }
    }
    return count
}
func BOJ_14502()
{
    let HW      = readLine()!.split(separator: " ").map{Int(String($0))!}
    let width   = HW[1]
    let height  = HW[0]
    var map     = Array(repeating: [Int](), count: height)
    var testMap = Array(repeating: Array(repeating: 0, count: width), count: height)
    var maximumSafetyArea = 0
    
    for y in 0..<height
    {
        map[y] = readLine()!.split(separator: " ").map{Int(String($0))!}
    }
    
    for y1 in 0..<height
    {
        for x1 in 0..<width
        {
            
            if y1 == height - 1 && x1 >= width - 2
            {
                break
            }
            if map[y1][x1] == 0
            {
                for y2 in 0..<height
                {
                    for x2 in 0..<width
                    {
                        if y2 == height - 1 && x2 >= width - 1
                        {
                            break
                        }
                        if x1 == x2 && y1 == y2 {continue}
                        if map[y2][x2] == 0
                        {
                            for y3 in 0..<height
                            {
                                for x3 in 0..<width
                                {
                                    if (x1 == x3 && y1 == y3) || (x2 == x3 && y2 == y3) {continue}
                                    if map[y3][x3] == 0
                                    {
                                        let pCluster = pointCluster(point(x1,y1), point(x2, y2), point(x3,y3))
                                        let tempCount = virus(width: width, height: height, pArray: pCluster, map: map)
                                        if tempCount > maximumSafetyArea
                                        {
                                            maximumSafetyArea = tempCount
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    print(maximumSafetyArea)
}

BOJ_14502()

