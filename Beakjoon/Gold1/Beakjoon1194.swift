//
//  Beakjoon1194.swift
//  Beakjoon
//
//  Created by 한현규 on 4/2/24.
//

import Foundation




class Beakjoon1194{
    func main(){
        let sizes = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let r = sizes[0]
        let c = sizes[1]
        
        var maze = [[Character]]()
        
        for _ in 0..<r{
            let row = readLine()!.compactMap { $0 }
            maze.append(row)
        }
        
        escapeMaze(r, c, maze)
    }

    ///empty: .
    ///wall: #
    ///key: a~f     -> 65 ~ 70
    ///door: A~F    -> 97 ~ 102
    ///start: 0
    ///out: 1

    func escapeMaze(_ r: Int, _ c: Int, _ maze: [[Character]]){
        let start = startPosition()
        
        
        // [key][r][c]
        var visited = Array.init(
            repeating: Array.init(
                repeating: Array.init(repeating: false, count: c),
                count: r
            ),
            count: Int(UInt8.max) + 1
        )
        
        
        var queue = [ ((Int, Int), Int, Int)]() //position, keys, count
        queue.append((start, 0, 0))
        visited[0][start.0][start.1] = true
        
        while !queue.isEmpty{
            let pop = queue.removeFirst()
            
            let position = pop.0
            let keys = pop.1
            let count = pop.2
            
            
            if maze[position.0][position.1] == "1"{
                print(count)
                return
            }
            
            let moves = [(1,0),(-1,0),(0,1),(0,-1)]
            for move in moves {
                let nextRow = move.0 + position.0
                let nextCol = move.1 + position.1
                
                if nextRow < 0 || nextCol < 0 || nextRow >= r || nextCol >= c{
                    continue
                }
                
                let next = maze[nextRow][nextCol]
                
                //isWall
                if next == "#"{
                    continue
                }
                
                //isVisited
                if visited[keys][nextRow][nextCol]{
                    continue
                }
                
                
                if isDoor(next){
                    if !hasKey(next, keys: keys){
                        continue
                    }
                    
                    visited[keys][nextRow][nextCol] = true
                    queue.append(((nextRow, nextCol), keys, count+1))
                    continue
                }
                
                
                
                if isKey(next){
                    let nextKeys = setKey(keys, next)
                    visited[nextKeys][nextRow][nextCol] = true
                    queue.append(((nextRow, nextCol), nextKeys, count+1))
                    continue
                }
                
                
                visited[keys][nextRow][nextCol] = true
                queue.append(((nextRow, nextCol), keys, count+1))
            }
            
        }
        
        
        print(-1)
        
        
        
        
        func startPosition() -> (Int, Int){
            for i in 0..<r{
                for j in 0..<c{
                    if maze[i][j] == "0"{
                        return  (i , j)
                    }
                }
            }
            fatalError()
        }
        
        
        
        func isDoor(_ character: Character) -> Bool{
            guard let ascii = character.asciiValue else { return false}
            return (65...70).contains(ascii)
        }
        
        func isKey(_ character: Character) -> Bool{
            guard let ascii = character.asciiValue else { return false}
            return (97...102).contains(ascii)
        }
        
        // a: 97 ->  1
        func setKey(_ keys: Int, _ newKey: Character) -> Int{
            let mask = 1 << (newKey.asciiValue! - 97)
            return keys | mask
        }
        
        // A: 65 -> 1
        func hasKey(_ door: Character, keys: Int) -> Bool{
            let masked = 1 << (door.asciiValue! - 65)
            return (keys & masked) != 0
        }
    }



}
