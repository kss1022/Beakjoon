//
//  Beakjoon2598.swift
//  Beakjoon
//
//  Created by 한현규 on 3/21/24.
//

import Foundation



class Beakjoon2598{

    func main(){
        
        let n = Int(readLine()!)!
        
        
        var edges = Array.init(
            repeating: Array(repeating: 0, count: n),
            count: n
        )
        
        for i in 0..<n{
            let row = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            for j in 0..<n{
                edges[i][j] = row[j]
            }
        }
        
        
        TSP(n, edges)
    }


    func TSP(_ n: Int, _ edges: [[Int]]){
        
        let VISITEDALL = (1 << n) - 1
        
        var mem =  Array.init(
            repeating: Array.init(repeating: -1, count: VISITEDALL+1),  //visited    n: 4  1111 -> 16
            count: n
        )
        
            
        print(dfs(0, visited: 1))

        func dfs(_ vertext: Int, visited: Int) -> Int{
            if mem[vertext][visited] != -1{
                return mem[vertext][visited]
            }
            
            if visitedAll(visited, n){
                mem[vertext][visited] = edges[vertext][0]       //Comback
                return mem[vertext][VISITEDALL]
            }
      
            var temp = Int.max
            for i in 1..<n{
                if visitedAt(visited, i) || edges[vertext][i] == 0{
                    continue
                }
                
                let nextDistance = dfs(i, visited: setVisited(visited, i))
                if  nextDistance == Int.max || nextDistance == 0{
                    continue
                }
                
                temp = min(temp, nextDistance + edges[vertext][i])
            }
            
            mem[vertext][visited] = temp
            return mem[vertext][visited]
        }
    }


    func visitedAll(_ visited: Int, _ n: Int) -> Bool{
        visited == (1 << n) - 1
    }

    func visitedAt(_ visited: Int, _ at: Int) -> Bool{
        let mask = 1 << at
        return (visited & mask) != 0
    }

    func setVisited(_ visited: Int, _ at: Int) -> Int{
        let mask = 1 << at
        return visited | mask
    }

    func setBit(_ bit: Int, _ index: Int) -> Int{
        let mask = 1 << index
        return bit | mask
    }

}
