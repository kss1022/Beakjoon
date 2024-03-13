//
//  Beakjoon17136.swift
//  Beakjoon
//
//  Created by 한현규 on 3/13/24.
//

import Foundation


class Beakjoon17136{

    func main(){
        let N = 10
        
        var boards = [[Int]]()
        
        for _ in 0..<N{
            let row = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            boards.append(row)
        }
        
        
        minPapers(N, boards)
    }

    //1×1, 2×2, 3×3, 4×4, 5×5
    func minPapers(_ N: Int,_ boards: [[Int]]){
        let paperCounts = [5,5,5,5,5]
        let positions = getPositions()
        let canFill = getCanFill()
        
        
        var result = Int.max
        fillPaperRecursive(0, canFill, paperCounts)
        
        if result == Int.max{
            result = -1
        }
        
        print(result)
        
        
        func fillPaperRecursive(_ deepth: Int,  _ canFill: [[Bool]], _ paperCounts: [Int]){
            if deepth == positions.count{
                let usePaper = paperCounts.reduce(25) { result, remain in
                    result - remain
                }
                result = min(usePaper, result)
                return
            }
            
            
            let position = positions[deepth]
            if !canFill[position.0][position.1]{
                fillPaperRecursive(deepth+1, canFill, paperCounts)
                return
            }
                    
            //5...1
            for size in stride(from: 5, through: 1, by: -1) {
                if !checkSize(position, size, canFill){
                    continue
                }
                
                if paperCounts[size-1] == 0{
                    continue
                }
                
                var canFill = canFill
                var paperCounts = paperCounts
                fillPaper(position, size, &canFill)
                paperCounts[size-1] -= 1
                fillPaperRecursive(deepth+1, canFill, paperCounts)
            }
        }
        
        
        
        
        
        
        func getPositions() -> [(Int, Int)]{
            var positions = [(Int, Int)]()
            for i in 0..<N{
                for j in 0..<N{
                    if boards[i][j] == 1{
                        positions.append((i, j))
                    }
                }
            }
            return positions
        }
        
        func getCanFill() -> [[Bool]]{
            var canFill = Array.init(
                repeating: Array.init(repeating: false, count: N),
                count: N
            )
            
            positions.forEach {
                canFill[$0.0][$0.1] = true
            }
            
            return canFill
        }
        
        func checkSize(_ position: (Int,Int), _ size: Int, _ canFill: [[Bool]]) -> Bool{
            let row = position.0
            let col = position.1
            
            if (row + size) > N || (col + size) > N{
                return false
            }
            
            for i in row..<(row+size){
                for j in col..<(col+size){
                    if !canFill[i][j]{
                        return false
                    }
                }
            }
            
            return true
        }
        
        func fillPaper(_ position: (Int,Int), _ size: Int, _ canFill: inout [[Bool]]){
            let row = position.0
            let col = position.1
            
            for i in row..<(row+size){
                for j in col..<(col+size){
                    canFill[i][j] = false
                }
            }
        }
        
    }


}
