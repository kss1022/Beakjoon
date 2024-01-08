//
//  Beakjoon2667.swift
//  Beakjoon
//
//  Created by 한현규 on 1/8/24.
//

import Foundation


class Beakjoon2667{
    func main(){
        let n = Int(readLine()!)!
        var map = [[Character]]()
        
        for _ in 0..<n{
            let row = readLine()!.compactMap { $0 }
            map.append(row)
        }
        
        solution(map: map, n: n)
    }

    func solution(map: [[Character]], n : Int){
        var map = map
        
        
        var groups = [Int]()
        
        for i in 0..<n{
            for j in 0..<n{
                if map[i][j] == "0"{
                    continue
                }
                
                let group =  bfs(map: &map, n: n, row: i, col: j)
                groups.append(group)
            }
        }
        
        
        print(groups.count)
        groups.sorted().forEach { print($0) }
    }


    func bfs(map: inout [[Character]], n: Int, row: Int, col: Int) -> Int{
        var nums = 0
        var queue = [(Int, Int)]()
        
        
        let start = (row, col)
        queue.append(start)
        map[row][col] = "0"
        
        let moves = [ (-1,0) , (1, 0), (0, -1), (0, 1) ]
        
        while !queue.isEmpty{
            let dequeue = queue.removeFirst()
            
            let row = dequeue.0
            let col = dequeue.1
            nums += 1
            
            for move in moves {
                let nextRow = row + move.0
                let nextCol = col + move.1
                
                if nextRow < 0  || nextRow >= n || nextCol < 0 || nextCol >= n{
                    continue
                }
                
                
                if map[nextRow][nextCol] == "0"{
                    continue
                }
                
                queue.append((nextRow, nextCol))
                map[nextRow][nextCol] = "0"
            }
        }
        
        
        return nums
    }

}
