//
//  Beakjoon2468.swift
//  Beakjoon
//
//  Created by 한현규 on 1/29/24.
//

import Foundation



class Beakjoon2468{
    func main(){
        let n = Int(readLine()!)!
        
        var heights = [[Int]]()
        
        for _ in 0..<n{
            let row = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
            heights.append(row)
        }
        
        let solution =  maxSafeLocations(heights: heights)
        print("\(solution)")
    }


    func maxSafeLocations(heights: [[Int]] ) -> Int{
        
        var maxHeight = 0
        
        let row = heights.count
        let col = heights[0].count
        
        for i in 0..<row{
            for j in 0..<col{
                maxHeight = max(heights[i][j], maxHeight)
            }
        }
        
        var maxSafeLocation = 1
        for i in 0..<maxHeight{
            let safeLocations =  safeLocations(heights: heights, rain: i)
            maxSafeLocation = max(safeLocations, maxSafeLocation)
        }
        
        return maxSafeLocation
    }

    func safeLocations(heights: [[Int]] , rain: Int) -> Int{
            
        var visited = [Position : Bool]()
                    
        let row = heights.count
        let col = heights[0].count
        
        var count = 0
        
        for i in 0..<row{
            for j in 0..<col{
                let check =  bfsSearch(heights: heights, rain: rain, visited: &visited, i: i, j: j)
                
                if check{
                    count += 1
                }
            }
        }
                    
        return count
    }


    func bfsSearch(heights: [[Int]], rain: Int, visited: inout [Position: Bool], i: Int, j: Int) -> Bool{
        if heights[i][j] <= rain{
            return false
        }
        
        let start = Position(row: i, col: j)
        if visited[start] == true{
            return false
        }
        
        
        var queue = [Position]()
        queue.append(start)
        
        while !queue.isEmpty{
            let pop = queue.removeFirst()
            let row = pop.row
            let col = pop.col

            [(-1, 0), (1, 0), (0, 1), (0, -1)].forEach { move in
                let nextRow = row + move.0
                let nextCol = col + move.1
                                        
                if nextRow < 0 ||  nextRow > (heights.count - 1) ||
                    nextCol < 0 || nextCol > (heights[0].count - 1){
                    return
                }
                
                let newPosition = Position(row: nextRow, col: nextCol)
                
                //Check height
                if heights[nextRow][nextCol] <= rain{
                    return
                }
                
                //Check visited
                if visited[newPosition] == true{
                    return
                }
                
                queue.append(newPosition)
                visited[newPosition] = true
            }
        }
        return true
    }


    struct Position: Hashable{
        let row: Int
        let col: Int
    }

}
