//
//  Beakjoon14502.swift
//  Beakjoon
//
//  Created by 한현규 on 2/9/24.
//

import Foundation


class Beakjoon14502{
    
    
    func main(){
        let size = readLine()!.components(separatedBy: .whitespaces)
            .compactMap(Int.init)
        
        let row = size[0]
        let col = size[1]
        
        var map = [[Int]]()
        
        
        for _ in 0..<row{
            let row = readLine()!.components(separatedBy: .whitespaces)
                .compactMap(Int.init)
            
            map.append(row)
        }
        
        maxSafeArea(map: map, row: row, col: col)
    }



    func maxSafeArea(map: [[Int]], row : Int, col: Int){
        var buildWalls = [[[Int]]]()
        var map = map
        buildWallsRecursive(map: &map, index: 0, count: 0, result: &buildWalls)
        
        var maxSize = 0
        
        
        buildWalls.forEach { map in
            let safeArea = safeArea(map: map, row: row, col: col)
            maxSize = max(safeArea, maxSize)
        }
        
        print("\(maxSize)")
    }


    func buildWallsRecursive(map: inout [[Int]], index: Int, count: Int, result: inout [[[Int]]]){
        if count == 3{
            result.append(map)
            return
        }
        
                    
        let maxIndex = map[0].count * map.count
        
        for i in index..<maxIndex{
            let row = i / (map[0].count)
            let col = i % (map[0].count)
            
            if map[row][col] != 0 {
                continue
            }
            
            var map = map
            map[row][col] = 1
            buildWallsRecursive(map: &map, index: i+1, count: count + 1, result: &result)
            map[row][col] = 0
        }
        

    }



    func safeArea(map: [[Int]], row: Int , col: Int) -> Int{
            
        var map = map
        var virus = [(Int,Int)]()
        
        for i in 0..<row{
            for j in 0..<col{
                if map[i][j] == 2{
                    virus.append((i,j))
                }
            }
        }
        
        while !virus.isEmpty{
            let pops = virus
            virus.removeAll()
            
            for pop in pops {
                let moves = [(-1,0), (1,0), (0, 1) ,(0, -1)]
                
                for move in moves {
                    let nextRow = move.0 + pop.0
                    let nextCol = move.1 + pop.1
                    
                    if nextRow < 0 || nextRow >= row || nextCol < 0 || nextCol >= col{
                        continue
                    }
                    
                    if map[nextRow][nextCol] != 0{
                        continue
                    }
                    
                    map[nextRow][nextCol] = 2
                    virus.append((nextRow, nextCol))
                }
            }
        }
        
        
        let result = map.reduce(0) { result, row in
            result + row.filter({ $0 == 0 }).count
        }
        
        return result
    }

}
