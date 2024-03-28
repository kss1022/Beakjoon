//
//  Beakjoon17472.swift
//  Beakjoon
//
//  Created by 한현규 on 3/28/24.
//

import Foundation



class Beakjoon17472{
    
    func main(){
        let sizes = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let r = sizes[0]
        let c = sizes[1]
        
        var map = [[Int]]()
        
        for _ in 0..<r{
            let row = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            map.append(row)
        }
        buildBridge(r, c, map)
    }

    /// bridge size >= 2
    ///
    ///7 8
    ///0 0 0 0 0 0 1 1
    ///1 1 0 0 0 0 1 1
    ///1 1 0 0 0 0 0 0
    ///1 1 0 0 0 1 1 0
    ///0 0 0 0 0 1 1 0
    ///0 0 0 0 0 0 0 0
    ///1 1 1 1 1 1 1 1

    func buildBridge(_ r: Int, _ c: Int, _ map: [[Int]]){
        let countries = getCountries(r, c, map)
        
        var edges = [((Int, Int), Int)]()
        
        for i in 0..<countries.count{
            let start = countries[i]
            for j in (i+1)..<countries.count{
                let distance = distance(start, countries[j], map)
                if distance == Int.max{
                    continue
                }
                
                edges.append(((i,j), distance))
            }
        }
      
        //mst
        print(mst(countries, edges))
    }



    func getCountries(_ r: Int, _ c: Int, _ map: [[Int]]) -> [Country]{
        var visited = Array.init(
            repeating: Array.init(repeating: false, count: c),
            count: r
        )
        
        var countries = [Country]()
        
        for i in 0..<r{
            for j in 0..<c{
                if map[i][j] == 0{
                    continue
                }
                
                if visited[i][j]{
                    continue
                }
                
                let positions = bfs(i, j)
                countries.append(Country(positions: positions))
            }
        }
        
                    
        func bfs(_ i: Int, _ j: Int) -> [(Int, Int)]{
            var positions = [(Int, Int)]()
            
            var queue = [(Int, Int)]()
            queue.append((i,j))
            visited[i][j] = true
            
            while !queue.isEmpty{
                let pop = queue.removeLast()
                
                positions.append((pop.0, pop.1))
                
                let moves = [(1,0),(-1,0),(0,1),(0,-1)]
                for move in moves{
                    let nextRow = pop.0 + move.0
                    let nextCol = pop.1 + move.1
                    
                    if nextRow < 0 || nextCol < 0 || nextRow >= r || nextCol >= c{
                        continue
                    }
                    
                    if visited[nextRow][nextCol]{
                        continue
                    }
                    
                    if map[nextRow][nextCol] == 0{
                        continue
                    }
                    
                    visited[nextRow][nextCol] = true
                    queue.append((nextRow, nextCol))
                }
                
                
                
                
            }
            return positions
        }
        
        
        return countries

    }

    func distance(_ start: Country, _ to : Country, _ map : [[Int]]) -> Int{
        var result = Int.max
        
        start.positions.forEach { startPosition in
            to.positions.forEach { toPosition in
                if startPosition.0 == toPosition.0{
                    //sameRow
                    
                    //check Size
                    let distance = abs(startPosition.1 - toPosition.1) - 1
                    if  distance < 2{
                        return
                    }
                    
                    //check canBridge
                    
                    let by = (startPosition.1 < toPosition.1) ? 1 : -1
                    let row = startPosition.0
                    for col in stride(from: startPosition.1+by, to: toPosition.1, by: by){
                        if map[row][col] == 1{
                            return
                        }
                    }
                    
                    result = min(distance, result)
                }else if startPosition.1 == toPosition.1{
                    //sameCol
                    
                    //check Size
                    let distance = abs(startPosition.0 - toPosition.0) - 1
                    if  distance < 2{
                        return
                    }
                    
                    
                    //check canBridge
                    let by = (startPosition.0 < toPosition.0) ? 1 : -1
                    let col = startPosition.1
                    for row in stride(from: startPosition.0+by, to: toPosition.0, by: by){
                        if map[row][col] == 1{
                            return
                        }
                    }
                    result = min(distance, result)
                }
            }
        }
        
        
        return result
    }

    func mst(_ countries: [Country], _ edges: [((Int,Int), Int)]) -> Int{
        if edges.count < countries.count-1{
            return -1
        }
        
        
        
        var parents = Array.init(repeating: 0, count: countries.count)
        for i in 0..<countries.count{
            parents[i] = i
        }
        
        let sorted = edges.sorted { $0.1 < $1.1 }
        var result = 0
        var count = 0
        
        for edge in sorted {
            let vertexs = edge.0
            let distance = edge.1
            
            let a = vertexs.0
            let b = vertexs.1
            
            if findParent(a, parents) == findParent(b, parents){
                continue
            }
            
            result += distance
            count += 1
            union(a, b, &parents)
        }
        
        if count < countries.count - 1{
            return -1
        }
              
        return result
    }


    func findParent(_ v: Int, _ parents: [Int]) -> Int{
        if parents[v] == v{
            return v
        }
        
        return findParent(parents[v], parents)
    }

    func union(_ a: Int, _ b: Int, _ parents: inout [Int]){
        let aParent = findParent(a, parents)
        let bParent = findParent(b, parents)
        
        if aParent < bParent{
            parents[bParent] = aParent
            return
        }
        
        parents[aParent] = bParent
    }




    struct Country{
        let positions: [(Int, Int)]
    }

}
