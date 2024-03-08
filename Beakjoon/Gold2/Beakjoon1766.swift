//
//  Beakjoon1766.swift
//  Beakjoon
//
//  Created by 한현규 on 3/8/24.
//

import Foundation



class Beakjoon1766{
    func main(){
        
        let nums = readLine()!.split(separator: " ")
            .compactMap { Int(String($0))! }
        
        let N = nums[0]
        let M = nums[1]
        
        
        var graph = Array.init(
            repeating: [Int](),
            count: N+1
        )
        
        var edges = Array.init(
            repeating: 0,
            count: N+1
        )
        
        for _ in 0..<M{
            let node = readLine()!.split(separator: " ")
                .compactMap { Int(String($0))! }
            graph[node[0]].append(node[1])
            edges[node[1]] += 1
        }
        
        for i in 0..<graph.count{
            graph[i].sort(by: >)
        }
        
        sortProblems(N, M, graph, edges)
    }


    func sortProblems(_ N: Int, _ M: Int, _ graph: [[Int]], _ edges: [Int]){
        
        var queue = PriorityQueue<Int>(ascending: true)
        var edges = edges
        
        for i in 1...N{
            if edges[i] == 0{
                queue.push(i)
            }
        }
        
        var result = [Int]()
        
        while !queue.isEmpty{
            let pop = queue.pop()!
            result.append(pop)
            
            
            for next in  graph[pop]{
                edges[next] -= 1
                if(edges[next] == 0){
                    queue.push(next)
                }
            }
        }
        
        print(result.map(String.init).joined(separator: " "))
      }


}
