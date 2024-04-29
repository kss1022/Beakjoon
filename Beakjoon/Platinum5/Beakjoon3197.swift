//
//  Beakjoon3197.swift
//  Beakjoon
//
//  Created by 한현규 on 4/29/24.
//

import Foundation


class Beakjoon3197{
    typealias Position = (row: Int, col: Int)
    var lake: [[Character]]!
    var r: Int!
    var c: Int!


    func main(){
        let sizes = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        r = sizes[0]
        c = sizes[1]
        lake = [[Character]]()
        for _ in 0..<r{
            lake.append(readLine()!.compactMap { $0 })
        }
        meetSwans()
    }






    func meetSwans(){
        var swans = [Position]()
        var water = [Position]()
        
        
        for row in 0..<r{
            for col in 0..<c{
                let position = (row, col)
                if isSwans(position){
                    swans.append(position)
                    water.append(position)
                }else if isWater(position){
                    water.append(position)
                }
            }
        }
        
        
        let start = swans[0]
        let to = swans[1]
        
        var visited = Array.init(
            repeating: Array.init(repeating: false, count: c),
            count: r
        )
        visited[start.row][start.col] = true
        
        //Swan Moves
        var swanQueue = [Position]()
        var front = 0
        swanQueue.append(start)
        
        
        var icesQueue = water
        
        var result = 0
        while true{
            result += 1
            icesQueue =  melt(icesQueue)
            
            if find(start, to, &swanQueue, &front, &visited){
                break
            }
        }
        
        print(result)
    }



    func find(_ start: Position, _ to: Position, _ queue: inout [Position], _ front: inout Int, _ visited: inout [[Bool]]) -> Bool{
        var ices = [Position]()
        
        while front < queue.count{
            let pop = queue[front]
            front += 1
            
            if pop == to{
                return true
            }
            
            let neighbors = [(1,0),(0,1),(-1,0),(0,-1)]
            for neighbor in neighbors {
                let nextRow = pop.row + neighbor.0
                let nextCol = pop.col + neighbor.1
                
                if nextRow < 0 || nextCol < 0 || nextRow >= r || nextCol >= c{
                    continue
                }
                
                let next: Position = (nextRow, nextCol)
                
                if visited[next.row][next.col]{
                    continue
                }
                
                if isIce(next){
                    ices.append(next)
                    visited[next.row][next.col] = true
                    continue
                }
                
                visited[next.row][next.col] = true
                queue.append(next)
            }
        }
        
        
        
        queue.append(contentsOf: ices)
        
        return false
    }



    func melt(_ queue: [Position]) -> [Position]{
        var meltIces = [Position]()
        
        var front = 0
        while front < queue.count{
            let pop = queue[front]
            front += 1
            
            
            
            let neighbors = [(1,0),(0,1),(-1,0),(0,-1)]
            for neighbor in neighbors {
                let nextRow = pop.row + neighbor.0
                let nextCol = pop.col + neighbor.1
            
                if nextRow < 0 || nextCol < 0 || nextRow >= r || nextCol >= c{
                    continue
                }
               
                let next: Position = (nextRow, nextCol)
                if isIce(next){
                    lake[next.row][next.col] = "."
                    meltIces.append(next)
                }
            }
        }
        return meltIces
    }



    func isSwans(_ position: Position) -> Bool{
        lake[position.row][position.col] == "L"
    }


    func isIce(_ position: Position) -> Bool{
        lake[position.row][position.col] == "X"
    }

    func isWater(_ position: Position) -> Bool{
        lake[position.row][position.col] != "X"
    }





}
