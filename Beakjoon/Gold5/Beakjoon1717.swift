//
//  Beakjoon1717.swift
//  Beakjoon
//
//  Created by 한현규 on 4/15/24.
//

import Foundation



class Beakjoon1717{

    func main(){
        let sizes = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let n = sizes[0]
        let m = sizes[1]
        

        
        var commands = [(Int, Int, Int)]()
        for _ in 0..<m{
            let command = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            commands.append( (command[0],command[1],command[2]) )
        }
        
        
        expressionSet(n, m, commands)
    }


    //0:  a가 포함되있는 집합과, b가 포함되있는 집합을 합친다.
    //1:  a,b가 같은 집합에 포함되어있는지 확인 "NO", "YES"


    func expressionSet(_ n: Int, _ m: Int, _ commands: [(Int, Int, Int)]){

        var parents = Array.init(repeating: 0, count: n+1)
        for i in 0...n{
            parents[i] = i
        }
        
        for command in commands {
            let type = command.0
            let a = command.1
            let b = command.2
            
            
            //union set
            if type == 0{
                union(a, b, &parents)
                continue
            }
            
            
            //check set
            let result = find(a, &parents) == find(b, &parents) ? "YES" : "NO"
            print(result)
        }
        
        
    }





    func find(_ a: Int, _ parents: inout [Int]) -> Int{
        if parents[a] == a{
            return a
        }
        
        parents[a] = find(parents[a], &parents)
        return parents[a]
    }


    func union(_ a: Int, _ b: Int, _ parents: inout [Int]){
        let aParent = find(a, &parents)
        let bParent = find(b, &parents)
        
        if aParent == bParent{
            return
        }
        
        if aParent < bParent{
            parents[bParent] = aParent
            return
        }
            
        parents[aParent] = bParent
    }

}
