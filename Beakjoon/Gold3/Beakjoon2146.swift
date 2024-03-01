//
//  Beakjoon2146.swift
//  Beakjoon
//
//  Created by 한현규 on 3/1/24.
//

import Foundation


class Beakjoon2146{
    
    func main(){
        let n = Int(readLine()!)!
        
        var map = [[Int]]()
        
        for _ in 0..<n{
            let row = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            map.append(row)
        }
        
        shortestBridgeLength(n, map)
    }

    func shortestBridgeLength(_ n: Int, _ map: [[Int]]){
        var country = [Position: Position]()    //edge: parent
        var visited = Set<Position>()
        
        
        for i in 0..<n{
            for j in 0..<n{
                setCountry(Position(i, j))
            }
        }
        
        var result = Int.max
        
        country.map { $0.key }
            .forEach {
                result = min(minDistance($0), result)
            }
        
        print(result)
        
        func setCountry(_ start: Position){
            
            if visited.contains(start) || map[start.row][start.col] == 0{
                return
            }
                    
                    
            var queue = [Position]()
            queue.append(start)
            visited.insert(start)
                    
            while !queue.isEmpty{
                let position = queue.removeFirst()
                                        
                let neighbors = [(1,0),(-1,0),(0,1),(0,-1)]
                for neighbor in neighbors {
                    let nextRow = position.row + neighbor.0
                    let nextCol = position.col + neighbor.1
                    
                    if nextRow < 0 || nextCol < 0 || nextRow >= n || nextCol >= n{
                        continue
                    }
                    
                    let newPosition = Position(nextRow, nextCol)
                    if visited.contains(newPosition){
                        continue
                    }
                    
                    //curent is Edge
                    if map[newPosition.row][newPosition.col] == 0{
                        country[position] = start
                        continue
                    }
                    
                    visited.insert(newPosition)
                    queue.append(newPosition)
                }
            }
        }
            
        
        func minDistance(_ start: Position) -> Int{
            var result = Int.max
                    
            var visited = Set<Position>()
            
            var queue = [(Position, Int)]()
            queue.append((start, 0))
            visited.insert(start)
            
            while !queue.isEmpty{
                let deQueue = queue.removeFirst()
                
                let position = deQueue.0
                let distance = deQueue.1
                
                if country[position] != nil && country[position] != country[start]{
                    result = distance-1
                    break
                }
                
                let neighbors = [(1,0),(-1,0),(0,1),(0,-1)]
                for neighbor in neighbors {
                    let nextRow = position.row + neighbor.0
                    let nextCol = position.col + neighbor.1
                    
                    if nextRow < 0 || nextCol < 0 || nextRow >= n || nextCol >= n{
                        continue
                    }
                    
                    let newPosition = Position(nextRow, nextCol)
                    if country[newPosition] == country[start]{
                        continue
                    }
                    
                    if visited.contains(newPosition){
                        continue
                    }
                    
                    
                    visited.insert(newPosition)
                    queue.append((newPosition, distance+1))
                }
                
            }
            
            return result
        }
        
    }



    struct Position: Hashable{
        let row: Int
        let col: Int
        
        init(_ row: Int, _ col: Int) {
            self.row = row
            self.col = col
        }
        
        static func ==(lhs: Position, rhs: Position) -> Bool{
            lhs.row == rhs.row && lhs.col == rhs.col
        }
    }

}
