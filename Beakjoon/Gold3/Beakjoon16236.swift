//
//  Beakjoon16236.swift
//  Beakjoon
//
//  Created by 한현규 on 2/21/24.
//

import Foundation



class Beakjoon16236{
    func main(){
        let n = Int(readLine()!)!
        
        var map = [[Int]]()
        for _ in 0..<n{
            let row = readLine()!.split(separator: " ")
                .compactMap{ Int(String($0)) }
            map.append(row)
        }
        
        helpDuration(n: n, a: map)
    }


    func helpDuration(n: Int, a: [[Int]]){
        var map = a
                
        var position = start()
        
        var result = 0
        var size = 2
        var eat = 0
        
        
        while true{
            let bfs = bfs()
            
            if bfs.0.isEmpty{
                break
            }
            
            let min = minAt(positions: bfs.0)
            move(min: min)
            eating()
            
            result += bfs.1
        }
        
        print("\(result)")
        
        
        
        func start() -> (Int,Int){
            for i in 0..<n{
                for j in 0..<n{
                    if map[i][j] == 9{
                        map[i][j] = 0
                        return (i, j)
                    }
                }
            }
            fatalError()
        }
        
        func bfs() -> ([(Int, Int)], Int){
            //bfs
            var visited = Array.init(
                repeating: Array.init(repeating: false, count: n),
                count: n
            )
                    
            var minDistance = Int.max
            var finds = [(Int,Int)]()
            
            var queue = [(Int,Int, Int)]()
            queue.append((position.0, position.1, 0))
            
            while !queue.isEmpty{
                let deQueue = queue.removeFirst()
                let row = deQueue.0
                let col = deQueue.1
                let distance = deQueue.2
                

                if minDistance < distance{
                    continue
                }
                
                if map[row][col] != 0 && map[row][col] < size{
                    minDistance = distance
                    finds.append( (row, col))
                    continue
                }
                
                
                let moves = [(1,0),(-1,0),(0,1),(0,-1)]
                
                for move in moves{
                    let nextRow = row + move.0
                    let nextCol = col + move.1
                    
                    if nextRow < 0 || nextCol < 0 || nextRow >= n || nextCol >= n {
                        continue
                    }
                    
                    
                    if visited[nextRow][nextCol]{
                        continue
                    }
                    
                    
                    if map[nextRow][nextCol] > size{
                        continue
                    }
                    
                    visited[nextRow][nextCol] = true
                    queue.append((nextRow, nextCol, distance + 1))
                }
            }
                    
            return (finds, minDistance)
        }
        
        func minAt(positions: [(Int, Int)] ) -> (Int, Int){
            positions.min { lhs , rhs in
                if lhs.0 == rhs.0{
                    return lhs.1 < rhs.1
                }
                
                return lhs.0 < rhs.0
            }!
        }
        
        func move(min: (Int, Int)){
            map[min.0][min.1] = 0
            position = min
        }
        
        func eating(){
            eat += 1
            if eat == size{
                size += 1
                eat = 0
            }
        }
        
    }





}
