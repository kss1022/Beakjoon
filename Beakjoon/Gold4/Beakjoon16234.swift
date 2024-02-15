//
//  Beakjoon16234.swift
//  Beakjoon
//
//  Created by 한현규 on 2/15/24.
//

import Foundation


class Beakjoon16234{
    
    func main(){
        let nums = readLine()!.split(separator: " ")
            .map(String.init)
            .compactMap(Int.init)
        
        let n = nums[0]
        let l = nums[1]
        let r = nums[2]
        
        var countries = [[Int]]()
        
        for _ in 0..<n{
            let row = readLine()!.split(separator: " ")
                .map(String.init)
                .compactMap(Int.init)
            countries.append(row)
        }
        
        var days = 0
        
        while true{
            if movePerson(n: n, l: l, r: r, countries: &countries){
                days += 1
                continue
            }
            
            break
        }
        
        print("\(days)")
    }


    func movePerson(n: Int, l: Int, r: Int, countries: inout [[Int]]) -> Bool{
        var move = false
        
        var visited = Array.init(
            repeating: Array.init(repeating: false, count: n),
            count: n
        )
                        

        
        for i in 0..<n{
            for j in 0..<n{
                if visited[i][j]{
                    continue
                }
                
                
                var union = [(Int, Int)]()
                union.append((i,j))
                unionRecursive(n: n, l: l, r: r, countries: countries, visited: &visited, union: &union, row: i, col: j)

                
                if union.count > 1{
                    move = true
                }
                
                //divide
                let persion = union.reduce(0) { result, point in
                    result +  countries[point.0][point.1]
                } / union.count
                
                union.forEach { point in
                    countries[point.0][point.1] = persion
                }
            }
        }

        
        return move
    }

    //dfs
    func unionRecursive(n: Int, l: Int, r: Int, countries: [[Int]], visited: inout [[Bool]], union: inout [(Int, Int)],row: Int , col: Int){
        if visited[row][col]{
            return
        }
        
        visited[row][col] = true
        
        let neighbors = [(1, 0), (0, 1), (-1, 0), (0,-1)]
        
        for neighbor in neighbors{
            let nextRow = neighbor.0 + row
            let nextCol = neighbor.1 + col
                    
            if nextRow < 0 || nextCol < 0 || nextRow >= n || nextCol >= n{
                continue
            }
            
            if visited[nextRow][nextCol]{
                continue
            }
                    
            let diff = abs( countries[row][col] - countries[nextRow][nextCol] )
            if diff >= l && diff <= r{
                union.append((nextRow,nextCol))
                unionRecursive(n: n, l: l, r: r, countries: countries, visited: &visited, union: &union, row: nextRow, col: nextCol)
            }
        }
    }



}
