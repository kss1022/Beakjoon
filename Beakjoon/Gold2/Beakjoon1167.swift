//
//  Beakjoon1167.swift
//  Beakjoon
//
//  Created by 한현규 on 3/4/24.
//

import Foundation


class Beakjoon1167{

    func main(){
        let V = Int(readLine()!)!
        
        var vertexs = Array.init(
            repeating: [(Int, Int)](),
            count: V
        )
        
        for _ in 0..<V{
            let edge = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
           
            if edge.count == 0{
                continue
            }
            
            
            for j in stride(from: 1, to: edge.count-1, by: 2){
                let vertex = edge[j]-1
                let distance = edge[j+1]
                vertexs[edge[0]-1].append((vertex, distance))
            }
        }
        
        treeMaxDistance(V, vertexs)
    }


    func treeMaxDistance(_ V: Int, _ vertexs: [[(Int, Int)]]){
        let findVertext = dfs(0)
        let result = dfs(findVertext.vertext)
        print("\(result.distance)")
        
        
        func dfs(_ start: Int) -> (distance: Int, vertext: Int){
            var visited = Set<Int>()
            
            var stack = [(Int, Int)]()
            stack.append((start,0))
            visited.insert(start)
            
            var maxDistance = 0
            var maxVertext = 0
            
            while !stack.isEmpty{
                let pop = stack.removeLast()
                let vertext = pop.0
                let distance = pop.1
                
                if maxDistance < distance{
                    maxDistance = distance
                    maxVertext = vertext
                }
                
                let neighbors = vertexs[vertext]
                for neighbor in neighbors{
                    let nextVertext = neighbor.0
                    if visited.contains(nextVertext){
                        continue
                    }
                    
                    let newDistance = neighbor.1 + distance
                    visited.insert(nextVertext)
                    stack.append((nextVertext, newDistance))
                }
            }
            
            return (maxDistance, maxVertext)
        }
    }

}
