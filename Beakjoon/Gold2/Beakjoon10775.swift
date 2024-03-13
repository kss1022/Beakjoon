//
//  Beakjoon10775.swift
//  Beakjoon
//
//  Created by 한현규 on 3/13/24.
//

import Foundation



class Beakjoon10775{

    func main(){
        let G = Int(readLine()!)!
        let P = Int(readLine()!)!
        
        var planes = [Int]()
        
        for _ in 0..<P{
            let plane = Int(readLine()!)!
            planes.append(plane)
        }
        
        dockingPlanes(G, P, planes: planes)
        
    }

    //greedy
    func dockingPlanes(_ ports: Int, _ numPlanes: Int, planes: [Int]){
        var gates = Array(repeating: 0, count: ports + 1)
        
        var results = 0
        
        var i = 0
        var keepGoing = true
        
        while i < numPlanes && keepGoing {
            var currentPlane = planes[i]
            while currentPlane > 0 && gates[currentPlane] > 0 {
                let t = gates[currentPlane]
                gates[currentPlane] += 1
                currentPlane -= t
            }
            
            if currentPlane <= 0 {
                keepGoing = false
            } else {
                gates[currentPlane] = 1
                results += 1
            }
            
            i += 1
        }
        
        print(results)
    }

    //union find
    func dockingPlanes2(_ ports: Int, _ numPlanes: Int, planes: [Int]){
        var result = 0
        
        var parents = Array(repeating: 0, count: ports + 1)
        for i in 1...ports{
            parents[i] = i
        }
        
        
        for i in 0..<numPlanes{
            let plane = planes[i]
            
            let parent = findParent(plane)
            parents[plane] = parent
            
            if parent == 0{
                break
            }
            
            union(parent-1, parent)
            result += 1
        }
        
        print(result)
        
        //a < b
        func union(_ a: Int, _ b: Int){
            let aParent = findParent(a)
            let bParent = findParent(b)
            parents[bParent] = aParent
        }
        
        func findParent(_ plane: Int) -> Int{
            if parents[plane] == plane{
                return plane
            }
            
            return findParent(parents[plane])
        }
        
    }


}
