//
//  Beakjoon9466.swift
//  Beakjoon
//
//  Created by 한현규 on 2/23/24.
//

import Foundation



class Beakjoon9466{
    func main(){
        let testCases = Int(readLine()!)!
        for _ in 0..<testCases{
            makeGroup()
        }

    }


    func makeGroup(){
        let n = Int(readLine()!)!
        
        
        let vertexs = readLine()!.split(separator: " ")
            .compactMap{ Int(String($0)) }
            .map { $0 - 1 }
        
        
        var mem = Array.init(repeating: 0, count: n) //0: not checked, 1: comback, -1: not comback
        
        
        for i in 0..<n{
            if mem[i] != 0{
                continue
            }
            findComeback(start: i, vertexs: vertexs)
        }
        
        
        let result = mem.filter { $0 == -1 }
            .count
        print("\(result)")
        
        
        
        
        func findComeback(start: Int, vertexs: [Int]){
            //dfs
            var visited = Set<Int>()
            var stack = [Int]()
            
            stack.append(start)
            visited.insert(start)
            
            while !stack.isEmpty{
                let pop = stack.removeLast()
                            
                let next = vertexs[pop]
                
                //next is Cycle
                if mem[next] != 0{
                    setNotComback()
                    return
                }
                
                //comback
                if next == start{
                    setComback()
                    return
                }
                
                //cycle
                if visited.contains(next){
                    setNotComback()
                    checkCycle(next)
                    return
                }
                            
                visited.insert(next)
                stack.append(next)
            }
            
            
            func setNotComback(){
                visited.forEach {
                    mem[$0] = -1
                }
            }
            
            func setComback(){
                visited.forEach {
                    mem[$0] = 1
                }
            }
                    
            func checkCycle(_ start: Int){
                var stack = [Int]()
                stack.append(start)
                mem[start] = 1
                
                while !stack.isEmpty{
                    let pop = stack.removeLast()
                                    
                    let next = vertexs[pop]
                                    
                    if next == start{
                        return
                    }
                    
                    mem[next] = 1
                    stack.append(next)
                }
            }
        }
        

    }



}
