//
//  Beakjoon1937.swift
//  Beakjoon
//
//  Created by 한현규 on 3/1/24.
//

import Foundation




class Beakjoon1937{

    func main(){
        let n = Int(readLine()!)!
        
        var map = [[Int]]()
        
        for _ in 0..<n{
            let row = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            map.append(row)
        }
        
        maxMoves(n, map: map)
    }

    func maxMoves(_ n: Int, map: [[Int]]){
        var mem = Array.init(
            repeating: Array.init(repeating: 0, count: n),
            count: n
        )
        
        var result = 0
        for i in 0..<n{
            for j in 0..<n{
                result =  max(maxMoveRecursive(pos: (i,j)), result)
            }
        }
        
        
        print("\(result)")
        
        func maxMoveRecursive(pos: (Int, Int)) -> Int{
            if mem[pos.0][pos.1] != 0{
                return mem[pos.0][pos.1]
            }
            
            mem[pos.0][pos.1] = 1
            
            let neighbors = [(-1,0),(1,0),(0,-1),(0,1)]
            for neighbor in neighbors {
                let nextRow = pos.0 + neighbor.0
                let nextCol = pos.1 + neighbor.1
                
                if nextRow < 0 || nextCol < 0 || nextRow >= n || nextCol >= n{
                    continue
                }
                
                if map[nextRow][nextCol] <= map[pos.0][pos.1]{
                    continue
                }
                
                mem[pos.0][pos.1] = max(maxMoveRecursive(pos: (nextRow, nextCol))+1, mem[pos.0][pos.1])
            }
            
            return mem[pos.0][pos.1]
        }
    }

}
