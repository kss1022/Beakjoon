//
//  Beakjoon11657.swift
//  Beakjoon
//
//  Created by 한현규 on 1/11/24.
//

import Foundation



final class Beakjoon11657{
    func main(){
        let nums = readLine()!.components(separatedBy: .whitespaces)
            .compactMap(Int.init)
        
        let n = nums[0]
        let m = nums[1]
        
        var busRoutes = [BusRoute]()
        
        
        for _ in 0..<m{
            let input = readLine()!.components(separatedBy: .whitespaces)
                .compactMap(Int.init) //0: Start, 1: End , 2: Time
            let busRoutine = BusRoute(start: input[0], end: input[1], distance: input[2])
            busRoutes.append(busRoutine)
        }
        
        minDistances(busRoutes: busRoutes, n: n, m: m)
    }

    ////Belman ford
    func minDistances(busRoutes: [BusRoute], n: Int, m: Int){
        var minDistances = Array.init(repeating: Int.max, count: n+1)
            
        minDistances[1] = 0
        
        for _ in 0..<(n-1){
            for j in 0..<m{
                let start = busRoutes[j].start
                let end = busRoutes[j].end
                let distance = busRoutes[j].distance

                
                let before = minDistances[start]
                let current = minDistances[end]
                
                if before == Int.max || current <= before + distance{
                    continue
                }
                
                minDistances[end] = minDistances[start] + distance
            }
        }
        
        for i in 0..<m{
            let start = busRoutes[i].start
            let end = busRoutes[i].end
            let distance = busRoutes[i].distance
            
            
            if minDistances[start] == Int.max{
                continue
            }
            
            if minDistances[end] > minDistances[start] + distance{
                print("-1")
                return
            }
        }
        
        for i in 2..<minDistances.count{
            let minDistance = minDistances[i]
            if minDistance == Int.max{
                print("-1")
                continue
            }
            
            print("\(minDistance)")
        }
        
    }


    struct BusRoute{
        let start: Int
        let end: Int
        let distance: Int
    }

}
