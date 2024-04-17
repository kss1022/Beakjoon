//
//  Beakjoon16946.swift
//  Beakjoon
//
//  Created by 한현규 on 4/17/24.
//

import Foundation


class Beakjoon16946{

    func main(){
        let sizes = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }

        //  1 ≤ r ≤ 1,000 , 1 ≤ c ≤ 1,000
        let r = sizes[0]
        let c = sizes[1]
        
        var map = [[Int]]()
        for _ in 0..<r{
            let row = readLine()!.compactMap { Int(String($0)) }
            map.append(row)
        }
        
        breakWalls(r, c, map)
    }

    func breakWalls(_ r: Int, _ c: Int, _ map: [[Int]]){
        let walls = walls(r, c, map)
        
        //graph
        var visited = Array.init(
            repeating: Array.init(repeating: false, count: c),
            count: r
        )
        
        
        //mem
        var parents = Array.init(
            repeating: Array.init(repeating: (0,0), count: c),
            count: r
        )
        
        for i in 0..<r{
            for j in 0..<c{
                parents[i][j] = (i,j)
            }
        }
        
        var sums = Array.init(
            repeating: Array.init(repeating: 0, count: c),
            count: r
        )
        
        
        
        var result = map
        
        for wall in walls {
            let neighbors = [(1,0), (0,1), (-1,0), (0,-1)]
            
            var neighborParents = Set<Parent>()
            
            for neighbor in neighbors {
                let nextRow = wall.0 + neighbor.0
                let nextCol = wall.1 + neighbor.1
                
                if nextRow < 0 || nextCol < 0 || nextRow >= r || nextCol >= c{
                    continue
                }
                        
                if isWall(map, nextRow, nextCol){
                    continue
                }
                
                findNeighborRecursive(
                    (nextRow, nextCol), (nextRow, nextCol),
                    &parents, &sums, &visited,
                    r, c, map
                )
                            
                neighborParents.insert(Parent(parents[nextRow][nextCol]))
            }
            
            result[wall.0][wall.1] = neighborParents.reduce(1) { partialResult, parent in
                partialResult + sums[parent.row][parent.col]
            } % 10
        }
        
        result.forEach { row in
            let rowJoined = row.map(String.init).joined()
            print(rowJoined)
        }
        
        

    }



    func findNeighborRecursive(
        _ current: (Int, Int),_ parent: (Int, Int),
        _ parents: inout [[(Int, Int)]], _ sums: inout [[Int]], _ visited: inout [[Bool]],
        _ r: Int, _ c: Int, _ map: [[Int]]
    ){
        if visited[current.0][current.1]{
            return
        }
        
        visited[current.0][current.1] = true
        parents[current.0][current.1] = parent
        sums[parent.0][parent.1] += 1
        
        
        let neighbors = [(1,0), (0,1), (-1,0), (0,-1)]
        for neighbor in neighbors {
            let nextRow = current.0 + neighbor.0
            let nextCol = current.1 + neighbor.1
            
            if nextRow < 0 || nextCol < 0 || nextRow >= r || nextCol >= c{
                continue
            }
            
                    
            if isWall(map, nextRow, nextCol){
                continue
            }
            
            if visited[nextRow][nextCol]{
                continue
            }
            
            
            findNeighborRecursive(
                (nextRow, nextCol), parent,
                &parents,&sums, &visited,
                r, c, map
            )
        }
        
    }





    func isWall(_ map: [[Int]], _ i: Int, _ j: Int) -> Bool{
        map[i][j] == 1
    }


    func walls(_ r: Int, _ c: Int, _ map: [[Int]]) -> [(Int, Int)]{
        var result = [(Int, Int)]()
        
        for i in 0..<r{
            for j in 0..<c{
                if isWall(map, i, j){
                    result.append((i,j))
                }
            }
        }
        
        return result
    }


    struct Parent: Hashable{
        let row: Int
        let col: Int
        
        init(_ parent: (Int, Int)) {
            self.row = parent.0
            self.col = parent.1
        }
    }

}
