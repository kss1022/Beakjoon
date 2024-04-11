//
//  Beakjoon9370.swift
//  Beakjoon
//
//  Created by 한현규 on 4/11/24.
//

import Foundation



class Beakjoon9370{

    func main(){
        let testCases = Int(readLine()!)!
        for _ in 0..<testCases{
            undefinedDestination()
        }
    }

    func undefinedDestination(){
        let nums = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let artist = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let _ = nums[0] //vertextCount
        let m = nums[1] //edgeCount
        let t = nums[2] //candidateCount
        
        let s = artist[0]  //start
        let g = artist[1]
        let h = artist[2]   //move edge of g-h
        
        
        var edges = [Int: [(Int, Int)]]() // V1, V2, distance
        for _ in 0..<m{
            let edge = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            
            appendEdge(&edges, edge[0], edge[1], edge[2])
            appendEdge(&edges, edge[1], edge[0], edge[2])
        }
        
        var candidates = [Int]()
        for _ in 0..<t{
            candidates.append(Int(readLine()!)!)
        }
        
        
        //startPoint
        //move      g-h
        //min Distance of Candidates
        
        
        //start -> dest   dikjstra  ( return is contain path )
        
        let paths = dikjstra(s, edges, (g, h))
        
        let results = candidates.filter { paths[$0] ?? false }
            .sorted()
            .map { String($0) }
            .joined(separator: " ")
        
        print(results)
    }

    func appendEdge(_ dic: inout [Int: [(Int,Int)]], _ vertext: Int, _ to: Int, _ distance: Int){
        if dic[vertext] == nil{
            dic[vertext] = []
        }
        dic[vertext]!.append((to, distance))
    }


    func dikjstra(_ start: Int, _ edges: [Int: [(Int, Int)]], _ path: (Int, Int)) -> [Int: Bool]{
        var minDists = [Int: Int]()
        var contianPaths =  [Int: Bool]()
        
        
        var queue = PriorityQueue<Edge>(ascending: true)
        minDists[start] = 0
        contianPaths[start] = false
        
        queue.push(Edge(start, 0))
        
        
        while !queue.isEmpty{
            let pop = queue.pop()!
            
            let vertext = pop.vertext
            let distance = pop.distance            
            
            let neighbors = edges[vertext] ??  []
            for (v, d) in neighbors{
                let nextDistance = distance + d
                
                let minDistance = minDists[v] ?? Int.max
                
                if minDistance < nextDistance{
                    continue
                }
                
                if minDistance == nextDistance{
                    contianPaths[v] = ( (contianPaths[vertext] ?? false) || containPath(vertext, v, path) ) || (contianPaths[v] ?? false)
                    continue
                }
                
                contianPaths[v] = ( (contianPaths[vertext] ?? false) || containPath(vertext, v, path) )
                
                
                minDists[v] = nextDistance
                queue.push(Edge(v, nextDistance))
            }
        }
        
        return contianPaths
    }

    func containPath(_ start: Int, _ to: Int, _ path: (Int, Int)) -> Bool{
        (start == path.0 && to == path.1) || (start == path.1 && to == path.0)
    }




    struct Edge: Comparable{
        let vertext: Int
        let distance: Int
        
        init(_ v: Int, _ distance: Int) {
            self.vertext = v
            self.distance = distance
        }
        
        static func <(lhs: Edge, rhs: Edge) -> Bool{
            lhs.distance < rhs.distance
        }
    }

}
