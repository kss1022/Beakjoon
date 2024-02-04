//
//  Beakjoon10026.swift
//  Beakjoon
//
//  Created by 한현규 on 2/4/24.
//

import Foundation



class Beakjoon10026{
    
    func main(){
        let n = Int(readLine()!)!
        
        var board = [[Character]]()
        
        for _ in 0..<n{
            let row = readLine()!.compactMap { $0 }
            board.append(row)
        }
        let areaCounts = areaCounts(board: board, n: n)
        print("\(areaCounts.0) \(areaCounts.1)")
    }

    
    func areaCounts(board: [[Character]], n: Int) -> (Int, Int){
        
        var normal: [[Character]] = board
        var normalArea = 0
        
        
        var redGreenDrug: [[Character]] = board.map {
            $0.map {
                if $0 == "G"{
                    return "R"
                }
                return $0
            }
        }
        var redGreenDrugArea = 0
        
        
        for i in 0..<n{
            for j in 0..<n{
                if normal[i][j] == " "{
                    continue
                }
                
                checkAreaBFS(mem: &normal, n: n, i: i, j: j)
                normalArea += 1
            }
        }
        
        for i in 0..<n{
            for j in 0..<n{
                if redGreenDrug[i][j] == " "{
                    continue
                }
                
                checkAreaBFS(mem: &redGreenDrug, n: n, i: i, j: j)
                redGreenDrugArea += 1
            }
        }
        
        return (normalArea,redGreenDrugArea)
    }


    func checkAreaBFS(mem: inout [[Character]], n: Int, i: Int, j: Int){
            let color = mem[i][j]
            
            var queue = [(Int, Int)]()
            queue.append((i,j))
            mem[i][j] = " "
            
            while !queue.isEmpty{
                let pop = queue.removeFirst()
        
        
                [(-1,0),(1,0),(0,-1),(0,1)].forEach {
                    let row = pop.0 + $0.0
                    let col = pop.1 + $0.1
                                        
                    if row < 0 || col < 0 || row > (n-1) || col > (n-1){
                        return
                    }
        
                    if mem[row][col] == " " || color != mem[row][col]{
                        return
                    }
        
                    mem[row][col] = " "
                    queue.append((row, col))
                }
            }
    }

}
