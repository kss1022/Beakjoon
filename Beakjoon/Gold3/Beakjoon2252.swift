//
//  Beakjoon2252.swift
//  Beakjoon
//
//  Created by 한현규 on 2/21/24.
//

import Foundation



class Beakjoon2252{
    func main(){
        let nums = readLine()!.split(separator: " ")
            .compactMap { Int(String($0))}
        
        let n = nums[0]
        let m = nums[1]
        
        var compares = Array.init(
            repeating: [Int](),
            count: n
        )
        
        
        for _ in 0..<m{
            let compare = readLine()!.split(separator: " ")
                .compactMap{ Int(String($0)) }
            compares[compare[0]-1].append(compare[1]-1)
            
        }
        
        topologicalSort(n: n, m: m, compares: compares)
    }


    func topologicalSort(n: Int, m: Int, compares: [[Int]]){
        //topological sorting
        
        var discovered = Set<Int>()
        var sorted = [Int]()
        
        
        for i in 0..<n{
            if discovered.contains(i){ continue}
            
            topologicalSortRecursive(num: i)
        }
        
        
        let result =  sorted.map{ "\($0 + 1)"}
            .joined(separator: " ")
        print("\(result)")
        
            
        //postOrder
        func topologicalSortRecursive(num: Int){
            discovered.insert(num)
            
            for neighbor in neightbores(num){
                if discovered.contains(neighbor){
                    continue
                }
                
                topologicalSortRecursive(num: neighbor)
                
            }
            
            sorted.insert(num, at: 0)
        }
        func neightbores(_ num: Int) -> [Int]{
            compares[num]
        }
    }
}
