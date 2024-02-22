//
//  Beakjoon1520.swift
//  Beakjoon
//
//  Created by 한현규 on 2/22/24.
//

import Foundation



class Beakjoon1520{
    func main(){
        let sizes = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let r = sizes[0]
        let c = sizes[1]
        
        var map = [[Int]]()
        
        for _ in 0..<r{
            let row = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            map.append(row)
        }
        numberOfPaths(r: r, c: c, map: map)
    }


    func numberOfPaths(r: Int, c: Int, map: [[Int]]){
        var dp = Array.init(
            repeating: Array.init(repeating: -1, count: c),
            count: r
        )
        let result = dfs(row: 0, col: 0)
        print("\(result)")
        
        func dfs(row: Int, col: Int) -> Int{
            if row == r-1 && col == c-1{
                return 1
            }
            
            if dp[row][col] != -1{
                return dp[row][col]
            }
            
            dp[row][col] = 0
            let moves = [(1,0),(-1,0),(0,1),(0,-1)]
            for move in moves {
                let nextRow = row + move.0
                let nextCol = col + move.1
                
                if nextRow < 0 || nextCol < 0 || nextRow >= r || nextCol >= c{
                    continue
                }
                
                if map[nextRow][nextCol] >= map[row][col]{
                    continue
                }
                
                dp[row][col] += dfs(row: nextRow, col: nextCol)
            }
                    
            return dp[row][col]
        }
        
    }

}
