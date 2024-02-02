//
//  Beakjoon1697.swift
//  Beakjoon
//
//  Created by 한현규 on 1/9/24.
//

import Foundation



class Beakjoon1697{
    func main(){
        let nums = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
        
        let minDistacne = minDistance(start: nums[0], end: nums[1])
        print("\(minDistacne)")
    }


    func minDistance(start: Int , end: Int) -> Int{
        
        var visited = [Int : Bool]()
        var queue = [(Int, Int)]()
        
        visited[end] = true
        queue.append((end, 0))
        
        
        while !queue.isEmpty{
            let deQueue = queue.removeFirst()
            
            let location = deQueue.0
            let distance = deQueue.1
            
            if location == start{
                return distance
            }
            
            var moves = [location-1, location+1]
            
            if location % 2 == 0{
                moves.append(location/2)
            }
                    
            for move in moves {
                if visited[move] == true{
                    continue
                }
                
                visited[move] = true
                queue.append( (move, distance + 1))
            }
        }
        
        return -1
    }


}
