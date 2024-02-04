//
//  Beakjoon15686.swift
//  Beakjoon
//
//  Created by 한현규 on 2/4/24.
//

import Foundation



class Beakjoon15686{
    func main(){
        let nums = readLine()!.components(separatedBy: .whitespaces)
            .compactMap(Int.init)
        
        let n = nums[0]
        let m = nums[1]
        
        var maps = [[Int]]()
        
        for _ in 0..<n{
            let row = readLine()!.components(separatedBy: .whitespaces)
                .compactMap(Int.init)
            maps.append(row)
        }
        
        let result = chickenLength(map: maps, n: n, m: m)
        print("\(result)")
    }

    func chickenLength(map: [[Int]],n: Int,  m: Int) -> Int{
        
        var chickens = [(Int, Int)]()
        var homes = [(Int, Int)]()
        
        for i in 0..<n{
            for j in 0..<n{
                if map[i][j] == 2{
                    let chicken = (i,j)
                    chickens.append(chicken)
                    continue
                }
                
                if map[i][j] == 1{
                    let home = (i,j)
                    homes.append(home)
                }
            }
        }
                    
        let combis =  combination(chickens, m)
        var result = Int.max
        
        combis.forEach { combi in
            var sum = 0
            
            
            homes.forEach { home in
                var minDistance = Int.max
                combi.forEach { chicken in
                    let xDis = abs(home.0 - chicken.0)
                    let yDis = abs(home.1 - chicken.1)
                    let distance = xDis + yDis
                    minDistance = min(minDistance, distance)
                }
                
                sum += minDistance
            }
            
            result = min(result, sum)
        }
        
        return result
    }

    func combination(_ chickens: [(Int, Int)], _ n: Int) -> [[(Int, Int)]] {
        var results = [[(Int, Int)]]()
        if chickens.count < n { return results }
        combinationRecursive(chikens: chickens, combi: [], index: 0, results: &results, n: n)
        return results
    }

    func combinationRecursive(chikens: [(Int, Int)], combi: [(Int, Int)], index: Int, results: inout [[(Int, Int)]], n: Int){
        if combi.count == n{
            results.append(combi)
            return
        }
        
        
        for i in index..<chikens.count{
            var combi = combi
            combi.append(chikens[i])
            combinationRecursive(chikens: chikens, combi: combi, index: i+1, results: &results, n: n)
        }
    }

}
