//
//  Beakjoon14890.swift
//  Beakjoon
//
//  Created by 한현규 on 2/23/24.
//

import Foundation



class Beakjoon14890{
    func main(){
        let sizes = readLine()!.split(separator: " ")
            .compactMap { Int(String($0))! }
        let n = sizes[0]
        let l = sizes[1]
        
        
        var map = [[Int]]()
        
        for _ in 0..<n{
            let row = readLine()!.split(separator: " ")
                .compactMap { Int(String($0))! }
            map.append(row)
        }
        
        pathOfRoads(n: n, l: l, map: map)
    }


    func pathOfRoads(n: Int, l: Int, map: [[Int]]){
        var result = 0
        
        for i in 0..<n{
            let row = map[i]
            var col = [Int]()
            for r in 0..<n{
                col.append(map[r][i])
            }
            
            if checkPath(row){
                result += 1
            }
            
            if checkPath(col){
                result += 1
            }
        }
        
        print("\(result)")
        
        func checkPath(_ roads: [Int]) -> Bool{
            var didSet = Array.init(repeating: false, count: n)
            var pivot = roads[0]
                    
            var i = 1
            while i < n{
                if pivot == roads[i]{
                    i += 1
                    continue
                }
                
                //check height

                let diff = pivot - roads[i]
                if abs(diff) != 1{
                    return false
                }
                
                if diff < 0{
                    //(i-1)-l+1 ~ (i-1)
                    if !checkSameHeight(roads: roads, start: i-l, end: i-1) ||
                        !checkSet(didSet: didSet, start: i-l, end: i-1){
                        return false
                    }
                    
                    pivot = roads[i]
                    for j in (i-l)...(i-1){
                        didSet[j] = true
                    }
                    continue
                }
                
                
                
                //i ~  i+l-1
                if !checkSameHeight(roads: roads, start: i, end: i+l-1) ||
                    !checkSet(didSet: didSet, start: i, end: i+l-1){
                    return false
                }
         
                pivot = roads[i+l-1]
                for j in i...(i+l-1){
                    didSet[j] = true
                }
                i = i+l
            }
            

             return true
        }
        
        func checkSameHeight(roads: [Int], start: Int, end: Int) -> Bool{
            if start < 0 || end < 0 || end >= n{
                return false
            }
            
            let height = roads[start]
            for i in start...end{
                if height != roads[i]{
                    return false
                }
            }
            
            return true
        }
        
        func checkSet(didSet: [Bool], start: Int, end: Int) -> Bool{
            for i in start...end{
                if didSet[i]{
                    return false
                }
            }
            
            return true
        }
            
        
    }

}
