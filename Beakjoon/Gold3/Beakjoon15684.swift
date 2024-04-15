//
//  Beakjoon15684.swift
//  Beakjoon
//
//  Created by 한현규 on 4/15/24.
//

import Foundation



class Beakjoon15684{


    func main(){
        let nums = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let n = nums[0]
        let m = nums[1]
        let h = nums[2]
        
        var edges = Array.init(
            repeating: Array.init(repeating: false, count: n),
            count: h
        )
        
        for _ in 0..<m{
            let edge = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            
            let a = edge[0]-1
            let b = edge[1]-1
            
            
            //b, b+1 at a
            edges[a][b] = true
        }
        
        topDown(n, m, h, edges)
    }


    func topDown(_ n: Int, _ m: Int, _ h: Int, _ edges: [[Bool]]){
        var newEdges = edges
        
        let row = h
        let col = n
        
        let candidate = candidate(row, col, edges)
        
        for count in 0...3{
            
            for combination in combination(row, col, count, newEdges, candidate){
                for edge in combination{
                    newEdges[edge.0][edge.1] = true
                }
                
                if checkTopDown(n, newEdges){
                    print(count)
                    return
                }
                
                for edge in combination{
                    newEdges[edge.0][edge.1] = false
                }
            }
        }
        
        
        print(-1)
    }

    func candidate(_ r: Int, _ c: Int, _ edges: [[Bool]]) -> [(Int, Int)]{
        
        var candidate = [(Int, Int)]()
        
        for i in 0..<r{
            if !edges[i][0] && !edges[i][1]{
                candidate.append((i, 0))
            }
        
        
            for j in 1..<(c-1){
                if !edges[i][j-1] && !edges[i][j] && !edges[i][j+1]{
                    candidate.append((i, j))
                }
            }
        }
        return candidate
    }


    func combination(_ r: Int, _ c: Int, _ count: Int,_ edges: [[Bool]], _ candidates: [(Int, Int)]) -> [[(Int, Int)]]{
        var result = [[(Int, Int)]]()
        var temp = edges
        combinationRecursive(r, c, [], 0, count, &temp, candidates, &result)
        return result
    }

    func combinationRecursive(_ r: Int, _ c: Int, _ current: [(Int, Int)], _ deepth: Int, _ count: Int,_ edges: inout [[Bool]], _ candidates: [(Int, Int)],_ result: inout [[(Int, Int)]]){
        if current.count == count{
            result.append(current)
            return
        }
        
        for index in deepth..<candidates.count{
            let i = candidates[index].0
            let j = candidates[index].1
            
            if checkNeighbor(i, j, edges){
                var next = current
                next.append((i,j))
                edges[i][j] = true
                combinationRecursive(r, c, next, index+1, count, &edges, candidates, &result)
                edges[i][j] = false
            }
            
        }
    }

    func checkNeighbor(_ i: Int, _ j: Int, _ edges: [[Bool]]) -> Bool{
        let left = j-1
        if left >= 0 && edges[i][left]{
            return false
        }
        
        let right = j+1
        if right < edges[0].count && edges[i][right]{
            return false
        }
        
        return true
    }



    func checkTopDown(_ n: Int, _ edges: [[Bool]]) -> Bool{
        for i in 0..<n{
            if !topDownRecursive(0, i, i, edges){
                return false
            }
        }
        
        return true
    }

    func topDownRecursive(_ row: Int, _ col: Int, _ start: Int, _ edges: [[Bool]]) -> Bool{
        if row == edges.count{
            return start == col
        }
         
        
        var nextCol = col
        if edges[row][col]{
            nextCol += 1
        }
        
        if col-1 >= 0 && edges[row][col-1]{
            nextCol -= 1
        }
        
        return topDownRecursive(row+1, nextCol, start, edges)
    }





}
