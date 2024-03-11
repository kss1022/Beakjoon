//
//  Beakjoon3109.swift
//  Beakjoon
//
//  Created by 한현규 on 3/11/24.
//

import Foundation



class Beakjoon3109{
    func main(){
        let nums = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let R = nums[0]
        let C = nums[1]
        
        var map = [[Character]]()
        
        for _ in 0..<R{
            let row = readLine()!.compactMap{ $0 }
            map.append(row)
        }
        
        buildPipeline(R, C, map)
    }


    func buildPipeline(_ R: Int, _ C: Int, _ map: [[Character]]){
        var visited = Array.init(
            repeating: Array.init(repeating: false, count: C),
            count: R
        )
        
        
        var result = 0

        for r in 0..<R{
            if dfsRecursive(row: r, col: 0, visited: &visited){
                result += 1
            }
        }
            
        print("\(result)")
        
        
        func dfsRecursive(row: Int, col: Int, visited: inout [[Bool]]) -> Bool{
            visited[row][col] = true
            
            if col == C-1{
                return true
            }
            
            
            let moves = [(-1,1), (0,1), (1, 1), ]  //RT, R,  RB
            for move in moves {
                let nextRow = row + move.0
                let nextCol = col + move.1
                
                if nextRow < 0 ||  nextCol < 0 || nextRow >= R || nextCol >= C{
                    continue
                }
                
                if visited[nextRow][nextCol]{
                    continue
                }
                
                if map[nextRow][nextCol] == "x"{
                    continue
                }
                
                if dfsRecursive(row: nextRow, col: nextCol, visited: &visited){
                    return true
                }
            }
            return false
        }

    }


}
