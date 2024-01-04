//
//  Beakjoon18232.swift
//  Beakjoon
//
//  Created by 한현규 on 1/3/24.
//

import Foundation



class Beakjoon18232{
    func run(){
        let nums = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
        
        let n = nums[0]
        let m = nums[1]
        
        
        let positions = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
        
        let start = positions[0]
        let end = positions[1]
        
        //Station -> [Station]
        var teleports = [Int: [Int]]()
        
        
        for _ in 0..<m{
            let teleport = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
            
            let a = teleport[0]
            let b = teleport[1]
            
            var tempA = teleports[a] ?? []
            tempA.append(b)
            teleports[a] = tempA
            
            var tempB = teleports[b] ?? []
            tempB.append(a)
            teleports[b] = tempB
        }
        
        
        let result = bfs(n: n, m: m, teleports: teleports, start: start, end: end)
        print("\(result)")
    }


    func bfs(n: Int, m: Int, teleports: [Int: [Int]], start: Int, end: Int) -> Int{
        
        
        var visited = [Int: Bool]()
        let queue = LinkedList<Move>()
            
        queue.append(Move(num: start, count: 0))
        visited[start] = true
                
        
        while !queue.isEmpty{
            let deQueue = queue.remove(at: 0)
            
            let num = deQueue.num
            let count = deQueue.count
                    
            if num == end{
                return count
            }
            
            //back
            if num-1 >= 1 && visited[num-1] != true{
                let move = Move(num: num-1, count: count+1)
                visited[num-1] = true
                queue.append(move)
            }
            
            //front
            if num+1 <= n && visited[num+1] != true{
                let move = Move(num: num+1, count: count+1)
                visited[num-1] = true
                queue.append(move)
            }
            
            
            //teleport
            if let childs = teleports[num]{
                for child in childs{
                    if visited[child] != true{
                        let move = Move(num: child, count: count+1)
                        visited[child] = true
                        queue.append(move)
                    }
                }
            }
        }
                        
        return -1
    }
    
    struct Move{
        let num: Int
        let count: Int
    }
    
}
