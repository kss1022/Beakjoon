//
//  Beakjoon4195.swift
//  Beakjoon
//
//  Created by 한현규 on 3/8/24.
//

import Foundation



class Beakjoon4195{
    func main(){
        let testCase = Int(readLine()!)!
            
        for _ in 0..<testCase{
            friendNetwork()
        }
    }


    func friendNetwork(){
        let n = Int(readLine()!)!
        
        var parents = [String: String]()
        var counts = [String: Int]()
        
        var result = ""
        for _ in 0..<n{
            let relationship = readLine()!.split(separator: " ").map(String.init)
            let a = relationship[0]
            let b = relationship[1]
            
            if findParent(a) == findParent(b){
                print("\(counts[findParent(a)]!)")
                continue
            }
            
            union(a, b)
            print("\(counts[findParent(a)]!)")
        }
            
        
        
        func findParent(_ person: String) -> String{
            if parents[person] == nil{
                parents[person] = person
                counts[person] = 1
                return person
            }
            
            
            if parents[person] == person{
                return person
            }
            return findParent(parents[person]!)
        }
        
        func union(_ a: String, _ b: String){
            let aParnet = findParent(a)
            let bParnet = findParent(b)
            
            
            if aParnet < bParnet{
                parents[bParnet] = aParnet
                counts[aParnet]! += counts[bParnet]!
                return
            }
            
            parents[aParnet] = bParnet
            counts[bParnet]! += counts[aParnet]!
        }
    }

}
