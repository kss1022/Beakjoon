//
//  Beakjoon12919.swift
//  Beakjoon
//
//  Created by 한현규 on 1/19/24.
//

import Foundation



class Beakjoon12919{
    func main(){
        let s = readLine()!
        let t = readLine()!
        
        canMakeT(s: s, t: t)
    }


    func canMakeT(s: String, t: String){
        
        // dfs
        var stack = [String]()
        stack.append(t)
        
        while !stack.isEmpty{
            let pop = stack.removeLast()
            
            if pop.count == s.count{
                if pop == s{
                    print("1")
                    return
                }
                continue
            }
            
            //A
            var removeA = pop
            if removeA.last == "A"{
                removeA.removeLast()
                stack.append(removeA)
            }
                            
            //B
            var removeB = pop
            if removeB.first == "B"{
                removeB = String(removeB.reversed())
                removeB.removeLast()
                stack.append(removeB)
            }
        }

        print("0")
    }

}
