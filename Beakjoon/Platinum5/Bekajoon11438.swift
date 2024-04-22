//
//  Bekajoon11438.swift
//  Beakjoon
//
//  Created by 한현규 on 4/22/24.
//

import Foundation


class Bekajoon11438{

    func main(){
        let n = Int(readLine()!)!
        
        var neighbors = Array.init(repeating: [Int](), count: n+1)
        
        for _ in 0..<(n-1){
            let neighbor = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            
            let a = neighbor[0]
            let b = neighbor[1]
            
            neighbors[a].append(b)
            neighbors[b].append(a)
        }
        
        let m = Int(readLine()!)!
        
        var pairs = [(Int, Int)]()
        
        for _ in 0..<m{
            let pair = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            pairs.append( (pair[0], pair[1]) )
        }
        
        findNearestParents(n, neighbors, m, pairs)
    }




    func findNearestParents(_ n: Int, _ neighbors: [[Int]], _ m: Int, _ pairs: [(Int, Int)]){
        var deepths = Array.init(repeating: -1, count: n+1)
        
        let LOG = 21    // 2^20 =  1000,000
        var parents = Array.init(
            repeating: Array.init(repeating: 0, count: LOG),
            count: n+1
        )
        
        
        
        var visited = Array.init(repeating: false, count: n+1)
        dfs(1, 0 ,neighbors, &deepths, &parents, &visited)
        setParents(n, LOG, &parents)

        
        pairs.forEach { (a, b) in
            print(findNearestParent(a, b, LOG,deepths, parents))
        }
    }

    func dfs(_ node: Int, _ deepth: Int,_ nodes: [[Int]],_ deepths: inout [Int], _ parents: inout [[Int]], _ visited: inout [Bool]){
        visited[node] = true
        deepths[node] = deepth
        
        for child in nodes[node]{
            if visited[child]{
                continue
            }
       
            parents[child][0] = node
            dfs(child, deepth+1, nodes, &deepths, &parents, &visited)
        }
    }

    /// parenst[vertext][2^ parents]
    func setParents(_ n: Int, _ LOG: Int,_ parents: inout [[Int]]){
        for pow in 1..<LOG{
            for vertext in 1...n{
                let before = parents[vertext][pow-1]
                parents[vertext][pow] = parents[before][pow-1]
            }
        }
    }

    func findNearestParent(_ a: Int, _ b: Int, _ LOG: Int, _ deepth: [Int], _ parents: [[Int]]) -> Int{                
        var a = a
        var b = b
        
        //b is more deepth
        if deepth[a] > deepth[b]{
            swap(&a, &b)
        }
        
        // deepth가 동일하도록 맞춰준다.  2^
        for i in stride(from: LOG-1, through: 0, by: -1){
            if deepth[b] - deepth[a] >= (1 << i){
                b = parents[b][i]
            }
        }
        
        if a == b{
            return a
        }
        
        //위와 동일하게 부모를 찾는다
        for i in stride(from: LOG-1, through: 0, by: -1){
            if parents[a][i] != parents[b][i]{
                a = parents[a][i]
                b = parents[b][i]
            }
        }
        
        return parents[a][0]
    }

}
