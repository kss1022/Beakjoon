//
//  Beakjoon2178.swift
//  Beakjoon
//
//  Created by 한현규 on 1/8/24.
//

import Foundation


class Beakjoon2178{
    func main(){
        let nums = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
        let n = nums[0]
        let m = nums[1]
        
        var maze = [[Character]]()
        
        for _ in 0..<n{
            let row = readLine()!.compactMap{ $0 }
            maze.append(row)
        }
        
        
        var result = solution(maze: maze, n: n, m: m)
        print("\(result)")
    }


    func solution(maze: [[Character]], n: Int, m: Int) -> Int{
        var visited = [Position: Int]()
        
        
        var queue = [Position]()
        
        let start = Position(row: 0, col: 0)
        queue.append(start)
        visited[start] = 1
        
        
        let moves = [(1,0), (0,1),(-1,0),(0,-1)]
        
        while !queue.isEmpty{
            let deQueue = queue.removeFirst()
            
            let row = deQueue.row
            let col = deQueue.col
            
            if row == n-1 && col == m-1{
                return visited[deQueue]!
            }
            
            for move in moves {
                let nextRow = row + move.0
                let nextCol = col + move.1
                
                
                if nextRow < 0 || nextRow >= n || nextCol < 0 || nextCol >= m{
                    continue
                }
                
                if maze[nextRow][nextCol] == "0"{
                    continue
                }
                
                let position = Position(row: nextRow, col: nextCol)
                if visited[position] == nil{
                    visited[position] = visited[deQueue]! + 1
                    queue.append(position)
                }
            }
            
        }
        
        
        return -1
    }




    struct Position: Hashable{
        let row: Int
        let col: Int
    }

}
