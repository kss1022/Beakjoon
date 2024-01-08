//
//  Beakjoon16948.swift
//  Beakjoon
//
//  Created by 한현규 on 1/5/24.
//

import Foundation



class Beakjoon16948{
    func run(){
        let size = Int(readLine()!)!
        
        let input = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
        
        let start = Position(input[0], input[1])
        let end = Position(input[2], input[3])
        
        bfs(size: size, start: start, end: end)
    }

    func bfs(size: Int,  start: Position, end: Position){
        var visited = [Position: Int]()
        
        var queue = [Position]()
        
        queue.append(start)
        visited[start] = 0
        
        while !queue.isEmpty{
            let deQeue = queue.removeFirst()
                            
            let row = deQeue.row
            let col = deQeue.col
            let count = visited[Position(row, col)]!
            
            if deQeue == end{
                print(count)
                return
            }
            
            if row-2 >= 0 && col-1 >= 0 {
                let new = Position(row-2, col-1)
                if visited[new] == nil{
                    queue.append(new)
                    visited[new] = count + 1
                }
            }
            
            if row-2 >= 0 && col+1 < size{
                let new = Position(row-2, col+1)
                if visited[new] == nil{
                    queue.append(new)
                    visited[new] = count + 1
                }
            }
            
            if col-2 >= 0{
                let new = Position(row, col-2)
                if visited[new] == nil{
                    queue.append(new)
                    visited[new] = count + 1
                }
            }
            
            if col+2 < size{
                let new = Position(row, col+2)
                if visited[new] == nil{
                    queue.append(new)
                    visited[new] = count + 1
                }
            }
            
            if row+2 < size && col-1 >= 0{
                let new = Position(row+2, col-1)
                if visited[new] == nil{
                    queue.append(new)
                    visited[new] = count + 1
                }
            }
            
            if row+2 < size && col+1 < size{
                let new = Position(row+2, col+1)
                if visited[new] == nil{
                    queue.append(new)
                    visited[new] = count + 1
                }
            }
        }
        print(-1)
    }




    struct Position: Hashable{
        let row: Int
        let col: Int
        
        init(_ row: Int,_ col: Int) {
            self.row = row
            self.col = col
        }
    }

}
