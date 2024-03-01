//
//  Beakjoon2638.swift
//  Beakjoon
//
//  Created by 한현규 on 3/1/24.
//

import Foundation



class Beakjoon2638{
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
        
         meltTimes(r, c, map)
    }


    /// 0: inside
    /// 1: cheese
    /// 2: outside


    func meltTimes(_ r: Int, _ c: Int, _ map: [[Int]]){
        var map = map
        
        var result = 0
            
        while true{
            meltCheeses()
            result += 1
            
            if checkAllMelt(){
                break
            }
        }
        
        print("\(result)")
        
        
        func meltCheeses(){
            checkOutside()
            
                    
                
            var melts = [(Int,Int)]()
            
            for i in 0..<r{
                for j in 0..<c{
                    meltCheese(i, j, &melts)
                }
            }
            
            for melt in melts {
                map[melt.0][melt.1] = 2
            }
        }
        
        
        func meltCheese(_ row: Int, _ col: Int, _ melts: inout [(Int, Int)]){
            if map[row][col] != 1{
                return
            }
            
            var count = 0
            let neighbors = [(1,0),(-1,0),(0,1),(0,-1)]
            for neighbor in neighbors {
                let nextRow = row + neighbor.0
                let nextCol = col + neighbor.1
                
                if nextRow < 0 || nextCol < 0 || nextRow >= r || nextCol >= c{
                    continue
                }
                            
                if map[nextRow][nextCol] == 2{
                    count += 1
                }
            }
            
            
            if count >= 2{
                melts.append( (row, col) )
            }
        }
        
        
        
        func checkAllMelt() -> Bool{
            for i in 0..<r{
                for j in 0..<c{
                    if map[i][j] == 1{
                        return false
                    }
                }
            }
            
            return true
        }
        
        func checkOutside(){
            var visited = Set<Position>()
                            
            var stack = [Position]()
            visited.insert(Position(0, 0))
            stack.append(Position(0, 0))
            
            
            while !stack.isEmpty{
                let pop = stack.removeLast()
                                
                
                let neighbors = [(1,0),(-1,0),(0,1),(0,-1)]
                for neighbor in neighbors {
                    let nextRow = pop.row + neighbor.0
                    let nextCol = pop.col + neighbor.1
                    
                    if nextRow < 0 || nextCol < 0 || nextRow >= r || nextCol >= c{
                        continue
                    }
                    
                    
                    if map[nextRow][nextCol] == 1{
                        continue
                    }
                    
                    let nextPosition = Position(nextRow, nextCol)
                    if visited.contains(nextPosition){
                        continue
                    }
                    
                    map[nextRow][nextCol] = 2   //set outside
                    
                    visited.insert(nextPosition)
                    stack.append(nextPosition)
                }
            }
        }
                
    }


    struct Position: Hashable{
        let row: Int
        let col: Int
        
        init(_ row: Int, _ col: Int) {
            self.row = row
            self.col = col
        }
    }

}
