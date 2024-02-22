//
//  Beakjoon1238.swift
//  Beakjoon
//
//  Created by 한현규 on 2/22/24.
//

import Foundation


class Beakjoon1238{
    func main(){
        let sizes = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let v = sizes[0]
        let e = sizes[1]
        let x = sizes[2] - 1
        
        
        var vertexs = Array.init(
            repeating: [(Int, Int)](),
            count: v
        )
        
        for _ in 0..<e{
            let edge = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            vertexs[edge[0]-1].append((edge[1]-1,edge[2]))
        }
        
        
        let xToVertexs = dijkstra(v: v, e: e, start: x, vertexs: vertexs)

        var result = Int.min
        
        for i in 0..<v{
            let vertextToX = dijkstra(v: v, e: e, start: i, vertexs: vertexs)
           result =  max(result, xToVertexs[i] + vertextToX[x])
        }
        
        print("\(result)")
    }


    func dijkstra(v: Int, e: Int, start: Int, vertexs: [[(Int, Int)]]) -> [Int]{
        var distances = Array.init(repeating: Int.max, count: v)
        distances[start] = 0
                    
        var queue = PriorityQueue<Candidate>(ascending: true)
        queue.push(Candidate(vertext: start, distance: 0))
        
        
        while !queue.isEmpty{
            let deQueue = queue.pop()!
            let vertext = deQueue.vertext
            let distance = deQueue.distance
            
            
            if distance > distances[vertext]{
                continue
            }
            
            for neighbor in vertexs[vertext]{
                let nextVertext = neighbor.0
                let nextDistance = neighbor.1 + distance
                
                if distances[nextVertext] <= nextDistance{
                    continue
                }
                
                distances[nextVertext] = nextDistance
                queue.push(Candidate(vertext: nextVertext, distance: nextDistance))
            }
        }
        
        return distances
    }

    struct Candidate: Comparable{
        let vertext: Int
        let distance:Int
        
        static func < (lhs: Candidate, rhs: Candidate) -> Bool {
            lhs.distance < rhs.distance
        }
    }

}
