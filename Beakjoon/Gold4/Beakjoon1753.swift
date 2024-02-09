//
//  Beakjoon1753.swift
//  Beakjoon
//
//  Created by 한현규 on 2/9/24.
//

import Foundation



class Beakjoon1753{
    func main(){
        let nums = readLine()!.components(separatedBy: .whitespaces)
            .compactMap(Int.init)
        
        let v = nums[0]
        let e = nums[1]
        
        
        let start = Int(readLine()!)!
        
        
        var edges = Array.init(
            repeating: [(Int,Int)](),
            count: v
        )
        
        for _ in 0..<e{
            let edge = readLine()!.split(separator: " ")
                .map(String.init)
                .compactMap(Int.init)
            edges[edge[0]-1].append((edge[1],edge[2]))
        }
                    
            
        dikjstra(v: v, e: e, edges: edges, start: start)
    }


    func dikjstra(v: Int, e: Int,  edges: [[(Int, Int)]], start: Int){
        var minDists = Array.init(
            repeating: Int.max,
            count: v
        )
        
        var queue = PriorityQueue<Candidate>()
        queue.push(Candidate(vertext: start, distance: 0))
        minDists[start - 1] = 0
        
        while !queue.isEmpty{
            let pop = queue.pop()!
            
            let vertext = pop.vertext
            let distance = pop.distance
            
            if distance > minDists[vertext-1]{
                continue
            }
            
            let neighbors = edges[vertext-1]
                
            for neighbor in neighbors {
                let nextEdge = neighbor.0
                let nextDistance = neighbor.1 + distance
                
                
                if nextDistance >= minDists[nextEdge-1]{
                    continue
                }
                
                minDists[nextEdge-1] = nextDistance
                queue.push(Candidate(vertext: nextEdge, distance: nextDistance))
            }
        }
        
        for minDist in minDists {
            if minDist == Int.max{
                print("INF")
                continue
            }
            
            print("\(minDist)")
        }
        
    }


    struct Candidate: Comparable{

        let vertext: Int
        let distance: Int
        
        //desc
        static func < (lhs: Candidate, rhs: Candidate) -> Bool {
            lhs.distance > rhs.distance
        }
    }

}
