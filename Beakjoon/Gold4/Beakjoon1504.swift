//
//  Beakjoon1504.swift
//  Beakjoon
//
//  Created by 한현규 on 2/16/24.
//

import Foundation



class Beakjoon1504{

    func main(){
        let nums = readLine()!.split(separator: " ")
            .map(String.init)
            .compactMap(Int.init)
        
        let V = nums[0]
        let E = nums[1]
        
        var edges = Array.init(
            repeating: [(Int, Int)](),
            count: V+1
        )
        
        for _ in 0..<E{
            let row = readLine()!.split(separator: " ")
                .map(String.init)
                .compactMap(Int.init)
            edges[row[0]].append( (row[1], row[2]) )
            edges[row[1]].append( (row[0], row[2]) )
        }
        
        //1 -> visitedEdge.0
        //visitedEdge.1 -> V
        
        let visitedEdge = readLine()!.split(separator: " ")
            .map(String.init)
            .compactMap(Int.init)
        
        
        let a = mid1ToMid2(V: V, E: E, edges: edges, visitedEdge: visitedEdge)
        let b = mid2ToMid1(V: V, E: E, edges: edges, visitedEdge: visitedEdge)
        
        
        if a == Int.max && b == Int.max{
            print("-1")
            return
        }
        
        
        let min = min(a, b)
        print(min)
    }


    func mid1ToMid2(V: Int, E: Int, edges: [[(Int,Int)]], visitedEdge: [Int]) -> Int{
        let startToMid1 =  minDistance(V: V, E: E, edges: edges, start: 1, destination: visitedEdge[0])
        if startToMid1 == Int.max{
            return Int.max
        }
        
        
        let mid1ToMid2 =  minDistance(V: V, E: E, edges: edges, start: visitedEdge[0], destination: visitedEdge[1])
        if mid1ToMid2 == Int.max{
            return Int.max
        }
        
        let mid2ToEnd =  minDistance(V: V, E: E, edges: edges, start: visitedEdge[1], destination: V)
        if mid2ToEnd == Int.max{
            return Int.max
        }
        
        return startToMid1 + mid1ToMid2 + mid2ToEnd
        
    }


    func mid2ToMid1(V: Int, E: Int, edges: [[(Int,Int)]], visitedEdge: [Int]) -> Int{
        let startToMid2 =  minDistance(V: V, E: E, edges: edges, start: 1, destination: visitedEdge[1])
        if startToMid2 == Int.max{
            return Int.max
        }
        
        
        let mid2ToMid1 =  minDistance(V: V, E: E, edges: edges, start: visitedEdge[1], destination: visitedEdge[0])
        if mid2ToMid1 == Int.max{
            return Int.max
        }
        
        let mid1ToEnd =  minDistance(V: V, E: E, edges: edges, start: visitedEdge[0], destination: V)
        if mid1ToEnd == Int.max{
            return Int.max
        }
        
        return startToMid2 + mid2ToMid1 + mid1ToEnd
    }

    func minDistance(V: Int, E: Int, edges: [[(Int,Int)]], start: Int , destination: Int) -> Int{
        var distances = Array.init(
            repeating: Int.max,
            count: V+1
        )
        
        
        distances[start] = 0
        
        var queue = PriorityQueue<Candidate>()
        queue.push(Candidate(vertext: start, distance: 0))
        
        while !queue.isEmpty{
            let deQueue = queue.pop()!
            
            let vertext = deQueue.vertext
            let distance = deQueue.distance
            
            if distance > distances[vertext]{
                continue
            }
            
            if vertext == destination{
                return distance
            }
            
            
            let neighbors = edges[vertext]
            for neighbor in neighbors{
                let nextVertext = neighbor.0
                let nextDistance = neighbor.1 + distance
                
                if nextDistance >= distances[nextVertext]{
                    continue
                }
                
                distances[nextVertext] = nextDistance
                queue.push(Candidate(vertext: nextVertext, distance: nextDistance))
            }
        }
        
        
        return distances[destination]
    }


    class Candidate: Comparable{
        
        //
        let vertext: Int
        let distance: Int
        
        init(vertext: Int, distance: Int) {
            self.vertext = vertext
            self.distance = distance
        }
        
        static func < (lhs: Candidate, rhs: Candidate) -> Bool {
            lhs.distance > rhs.distance
        }
        
        static func == (lhs: Candidate, rhs: Candidate) -> Bool {
            lhs.distance == rhs.distance
        }
    }
}
