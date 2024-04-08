//
//  Beakjoon3665.swift
//  Beakjoon
//
//  Created by 한현규 on 4/8/24.
//

import Foundation



class Beakjoon3665{
    func main(){
        let testCases = Int(readLine()!)!
        for _ in 0..<testCases{
            finalRanking()
        }
    }

    func finalRanking(){
        let n = Int(readLine()!)!
        
        let teams = readLine()!.split(separator: " ")
            .map { Int(String($0))! - 1 }
        
        
        let c = Int(readLine()!)!
        
        var changes = [(a: Int, b: Int)]()
        for _ in 0..<c{
            let change = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            changes.append((change[0]-1, change[1]-1))
        }
        
          
        var compares = Array.init(repeating: [Int](), count: n)
        var indegress = Array.init(repeating: 0, count: n)
            
        
        for i in 0..<n{
            for j in (i+1)..<n{
                compares[teams[i]].append(teams[j])
                indegress[teams[j]] += 1
            }
        }
        
        
        for change in changes {
            let isContain = compares[change.a].contains { $0 == change.b }
            
            let up = isContain ? change.a : change.b
            let down = isContain ? change.b : change.a
                    
            if let findIndex = compares[up].firstIndex(of: down){
                compares[up].remove(at: findIndex)
                indegress[up] += 1
                compares[down].append(up)
                indegress[down] -= 1
            }else{
                print("IMPOSSIBLE")
                return
            }
        }
        
        let sorted = topologicalSort(n, compares, indegress)
            
        if !sorted.isEmpty{
            let sortedToString = sorted
                .map{ $0 + 1 }
                .map(String.init)
                .joined(separator: " ")
            print(sortedToString)
        }
    }


    func topologicalSort(_ n: Int,_ compares: [[Int]], _ indegress: [Int]) -> [Int]{
        var sorted = [Int]()
        
        var indegress = indegress
        
        var queue = [Int]()
        
        for i in 0..<n{
            if indegress[i] == 0{
                queue.append(i)
            }
        }
        
        while !queue.isEmpty{
            if queue.count > 1{
                print("?")
                return []
            }
                    
            let pop = queue.removeFirst()
            
            sorted.append(pop)
            
            for vertex in compares[pop]{
                indegress[vertex] -= 1
                if indegress[vertex] == 0{
                    queue.append(vertex)
                }
            }
        }
        
        if sorted.count != n{
            print("IMPOSSIBLE")
            return []
        }
        
        return sorted
    }



    //func topologicalSort(_ n: Int,_ compares: [[Int]]) -> [Int]{
    //    var discovered = Set<Int>()
    //    var sorted = [Int]()
    //
    //    for i in 0..<n{
    //
    //        if discovered.contains(i){
    //            continue
    //        }
    //
    //        topologicalSortRecursive(i)
    //    }
    //
    //    return sorted
    //
    //    func topologicalSortRecursive(_ num: Int){
    //        discovered.insert(num)
    //
    //        for neighbor in compares[num]{
    //            if discovered.contains(neighbor){
    //                continue
    //            }
    //
    //            topologicalSortRecursive(neighbor)
    //        }
    //
    //
    //
    //        sorted.insert(num, at: 0)
    //    }
    //
    //}
    //

}
