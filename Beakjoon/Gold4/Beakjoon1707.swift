//
//  Beakjoon1707.swift
//  Beakjoon
//
//  Created by 한현규 on 2/16/24.
//

import Foundation



final class Beakjoon1707{
    func main(){
        let testCases = Int(readLine()!)!
        
        for _ in 0..<testCases{
            bipartiteGraph()
        }
    }



    func bipartiteGraph(){
        let nums = readLine()!.split(separator: " ")
            .map(String.init)
            .compactMap(Int.init)
        
        let V = nums[0]
        let E = nums[1]
        
        
        var edges = Array.init(
            repeating: Set<Int>(),
            count: V + 1
        )
        
        
        for _ in 0..<E{
            let edge = readLine()!.split(separator: " ")
                .map(String.init)
                .compactMap(Int.init)
                    
            edges[edge[0]].insert(edge[1])
            edges[edge[1]].insert(edge[0])
        }

        //checkbipartiteGraphDFS(V: V, edges: edges)
        checkbipartiteGraphBFS(V: V, edges: edges)
    }



    //visited ->    0: is not visited   1:GroupA   -1:GroupB

    func checkbipartiteGraphBFS(V: Int, edges: [Set<Int>]){
        var visited = Array.init(repeating: 0, count: V+1)
        var isBipartite = true
        
        for i in 1...V{
            if visited[i] != 0{
                continue
            }
            
            if !checkbipartiteGraphBFS(v: i, edges: edges, visited: &visited){
                isBipartite = false
                break
            }
        }
        
        if isBipartite{
            print("YES")
            return
        }
        
        print("NO")
    }


    func checkbipartiteGraphBFS(v: Int,edges: [Set<Int>], visited: inout [Int]) -> Bool{
        

        var queue = [Int]()
            
        queue.append(v)
        visited[v] = 1
        
        while !queue.isEmpty{
            let deQueue = queue.removeFirst()
            
            let vertext = deQueue
            let group = visited[vertext]
            
            
            let neighbors = edges[vertext]
            for neighbor in neighbors{
                if visited[neighbor] == 0{
                    visited[neighbor] = group  * -1
                    queue.append(neighbor)
                    continue
                }
                            
                if visited[neighbor] == group{
                    return false
                }
            }
        }
        
        
        return true
    }




    func checkbipartiteGraphDFS(V : Int, edges: [Set<Int>]){

        var visited = Array.init(repeating: 0, count: V+1)
        
        
        for i in 1...V{
            checkbipartiteGraphRecursive(v: i, edges: edges, visited: &visited)
        }
        
        
        let isBipartGraph = isBipartiteGraph(edges: edges, visited: visited)
        if isBipartGraph{
            print("YES")
            return
        }
        
        print("NO")
    }

    func checkbipartiteGraphRecursive(v : Int, edges: [Set<Int>], visited: inout [Int]){
        if visited[v] == 0{
            visited[v] = 1
        }
        
        
        let neighbors = edges[v]
        
        for neighbor in neighbors{
            if visited[neighbor] != 0{
                continue
            }
            
            visited[neighbor] = visited[v] * -1

            checkbipartiteGraphRecursive(v: neighbor, edges: edges, visited: &visited)
        }
        
    }



    func isBipartiteGraph(edges: [Set<Int>], visited: [Int]) -> Bool{
        for i in 1..<edges.count{
            let edges = edges[i]
            
            for vertex in edges{
                if visited[i] == visited[vertex]{
                    return false
                }
            }
            
        }
        return true
    }

}
