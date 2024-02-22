//
//  Beakjoon1005.swift
//  Beakjoon
//
//  Created by 한현규 on 2/22/24.
//

import Foundation



class Beakjoon1005{

    let fileIO = FileIO()

    func main(){
        let testCases = fileIO.readInt()
        
        for _ in 0..<testCases{
            fastBuildTimes()
        }
    }


    func fastBuildTimes(){
        
        let (n, k) = (fileIO.readInt(), fileIO.readInt())

        
        
        var buildTimes = [Int]()
        for _ in 0..<n{
            buildTimes.append(fileIO.readInt())
        }
        
        var requires = Array.init(
            repeating: [Int](),
            count: n
        )
            
        for _ in 0..<k{
            let rule = [fileIO.readInt(), fileIO.readInt()]
            requires[rule[0]-1].append(rule[1]-1)
        }
        
        let lastBuilding = fileIO.readInt() - 1

        var visited = Set<Int>()
        var sorted = [Int]()
        
        for i in 0..<n{
            if visited.contains(i){
                continue
            }
            
            topologicalSort(building: i)
        }
        
        
        print("\(dp())")
        
        func topologicalSort(building: Int){
            visited.insert(building)
            
            for next in requires[building]{
                if visited.contains(next){
                    continue
                }
                
                topologicalSort(building: next)
            }
            
            sorted.insert(building, at: 0)
        }
        
        func dp() -> Int{
            var mem = buildTimes
            //mem[sorted.first!] = buildTimes[sorted.first!]
            
            var stack = sorted
            
            while !stack.isEmpty{
                let building = stack.removeFirst()
                            
                if building == lastBuilding{
                    break
                }
                
                for nextBuilding in requires[building]{
                    let nextTime = mem[building] + buildTimes[nextBuilding]
                    mem[nextBuilding] = max(mem[nextBuilding], nextTime)
                }
            }
            
            
            return mem[lastBuilding]
        }
        
        
        
        
    //    var mem = Array.init(repeating: 0, count: n)
    //    var visited = Array.init(repeating: false, count: n)
    //
    //    let result = dfs(building: lastBuilding)
    //    print("\(result)")
    //
    //
    //    func dfs(building: Int) -> Int{
    //        if visited[building]{
    //            return mem[building]
    //        }
    //
    //        mem[building] = requires[building].map({ dfs(building: $0) }).max() ?? 0
    //        mem[building] += buildTimes[building]
    //        visited[building] = true
    //
    //        return mem[building]
    //    }
    //
    //
    }

}
