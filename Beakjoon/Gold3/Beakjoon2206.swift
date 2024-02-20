//
//  Beakjoon2206.swift
//  Beakjoon
//
//  Created by 한현규 on 2/20/24.
//

import Foundation


class Beakjoon2206{
    func main(){
        let sizes = readLine()!.split(separator: " ")
            .map(String.init)
            .compactMap(Int.init)
        
        let r = sizes[0]
        let c = sizes[1]
        
        var map = [[Character]]()
        
        for _ in 0..<r{
            let row = readLine()!.compactMap { $0 }
            map.append(row)
        }
        
        minDistance(r: r, c: c, map: map)
    }

    func minDistance(r: Int, c: Int, map: [[Character]]){
        var visited = Array.init(
            repeating: Array.init(repeating: [false, false], count: c),
            count: r
        )
        
        var queue = [((Int, Int, Int), Int)]()   //(row, col, distance), isBroken()   0:not 1:true
        queue.append( ((0,0,1), 0)  )
        visited[0][0][0] = true
            
        var index = 0
        
        
        while queue.count > index{
            let deQueue = queue[index]
            
            let row = deQueue.0.0
            let col = deQueue.0.1
            let distance = deQueue.0.2
            let isBroken = deQueue.1
            
            if row == r-1 && col == c-1{
                print("\(distance)")
                return
            }
            
            
            let moves = [(1,0),(-1,0),(0,1),(0,-1)]
            for move in moves {
                let nextRow = row + move.0
                let nextCol = col + move.1
                
                if nextRow < 0 || nextCol < 0 || nextRow >= r || nextCol >= c{
                    continue
                }
                
                if visited[nextRow][nextCol][isBroken]{
                    continue
                }
                
                                        
                if map[nextRow][nextCol] == "0"{
                    visited[nextRow][nextCol][isBroken] = true
                    queue.append( ((nextRow, nextCol, distance+1), isBroken ))
                    continue
                }
                            
                if isBroken == 0{
                    visited[nextRow][nextCol][1] = true
                    queue.append( ((nextRow, nextCol, distance+1), 1 ))
                }
            }
            
            index += 1
        }
        
        print("-1")
    }

}
