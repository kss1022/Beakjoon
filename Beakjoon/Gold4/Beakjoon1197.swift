//
//  Beakjoon1197.swift
//  Beakjoon
//
//  Created by 한현규 on 2/13/24.
//

import Foundation




class Beakjoon1197{
    func main(){
        let nums = readLine()!.split(separator: " ")
            .map(String.init)
            .compactMap(Int.init)
        
        let v = nums[0]
        let e = nums[1]
        
        var edges = [ (Int, (Int,Int)) ]()
        
        for _ in 0..<e{
            let edge = readLine()!.split(separator: " ")
                .map(String.init)
                .compactMap(Int.init)
            
            let v1 = edge[0] - 1
            let v2 = edge[1] - 1
            let weight = edge[2]
            
            edges.append((weight, (v1,v2)))
        }
        

        graphMinWeights(v: v, e: e, edges: edges)
    }

    func graphMinWeights(v: Int, e: Int, edges: [(Int,  (Int,Int))]){
        //kruskal
        let edges = edges.sorted {
            $0.0 < $1.0
        }
        
        
        var parents = Array.init(repeating: 0, count: v)
        for i in 0..<parents.count{
            parents[i] = i
        }
        
        var weightSum = 0
        for i in 0..<e{
            let edge = edges[i]
            let weight = edge.0
            let vertexs = edge.1
            
            
            if findParent(parents: parents, v: vertexs.0) == findParent(parents: parents, v: vertexs.1){
                continue
            }
            
            weightSum += weight
            union(parent: &parents, a: vertexs.0, b: vertexs.1)
        }
        
        print("\(weightSum)")
    }


    func union(parent: inout [Int], a: Int, b: Int){
        let aParent = findParent(parents: parent, v: a)
        let bParent = findParent(parents: parent, v: b)
        
        if(aParent < bParent) {
            parent[bParent] = aParent
            return
        }
           
        
        parent[aParent] = bParent
    }

    func findParent(parents: [Int], v: Int) -> Int{
        if (parents[v] == v){
            return v
        }
                    
        return findParent(parents: parents, v: parents[v])
    }

}
