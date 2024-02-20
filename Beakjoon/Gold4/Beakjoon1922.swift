//
//  Beakjoon1922.swift
//  Beakjoon
//
//  Created by 한현규 on 2/20/24.
//

import Foundation



class Beakjoon1922{
    func main(){
        let v = Int(readLine()!)!
        let e = Int(readLine()!)!
        
        
        var edges = [(Int, Int, Int)]()
        
        for _ in 0..<e{
            let edge = readLine()!.split(separator: " ")
                .map(String.init)
                .compactMap(Int.init)
            
            edges.append((edge[0]-1, edge[1]-1, edge[2]))
        }
        
        minConnectPrice(v: v, e: e, edges: edges)
    }


    func minConnectPrice(v: Int, e: Int, edges: [(Int,Int,Int)]){
        //mst
        //kruskal
        
        let edges = edges.sorted { $0.2 < $1.2 }
        
        var parents = Array.init(repeating: 0, count: v)
        for i in 0..<v{
            parents[i] = i
        }
        
        
        var minSum = 0
        
        for i in 0..<e{
            let edge = edges[i]
            let a = edge.0
            let b = edge.1
            let distance = edge.2
            
            if findParent(v: a, parent: parents) == findParent(v: b, parent: parents){
                continue
            }
            
            minSum += distance
            union(a: a, b: b, parent: &parents)
        }
        
        print("\(minSum)")
    }

    func findParent(v: Int, parent: [Int]) -> Int{
        if parent[v] == v{
            return v
        }
        
        return findParent(v: parent[v], parent: parent)
    }


    func union(a: Int, b: Int, parent: inout [Int]){
        let aParent = findParent(v: a, parent: parent)
        let bParent = findParent(v: b, parent: parent)
        
        //더 작은 수를 부모로 한다.
        if aParent < bParent{
            parent[bParent] = aParent
            return
        }
        
        parent[aParent] = bParent
    }

}
