//
//  Beakjoon2110.swift
//  Beakjoon
//
//  Created by 한현규 on 2/15/24.
//

import Foundation



class Beakjoon2110{


    func main(){
        let nums = readLine()!.split(separator: " ")
            .map(String.init)
            .compactMap(Int.init)
        
        let n = nums[0]
        let c = nums[1]
        
        var houses = [Int]()
        for _ in 0..<n{
            let house = Int(readLine()!)!
            houses.append(house)
        }
        
        maxModenDistance(n: n, c: c, houses: houses.sorted())
    }

    //  1   2   4   8   9
    func maxModenDistance(n: Int, c: Int, houses: [Int]){
        

        let minDistance = 1
        let maxDistance = houses[n-1] - houses[0]
        

        binarySearch(houses: houses, minDistance: minDistance, maxDistance: maxDistance, c: c)
    }


    func binarySearch(houses: [Int], minDistance: Int, maxDistance: Int, c: Int){
        
        var start = minDistance
        var end = maxDistance
        var result = 0
        
        while start <= end{
            let mid = (end + start) / 2
            let count = houseCount(houses: houses, mid: mid)
            
            if count <  c{
                end = mid - 1
                continue
            }
            
            
            start = mid + 1
            result = max(result, mid)
        }
        
        print("\(result)")
    }

    //mid일떄 가능한 house의 개수를 더해준다.
    func houseCount(houses: [Int], mid: Int) -> Int{
        var count = 1
        var before = houses[0]
        
        for i in 1..<houses.count{
            let now = houses[i]
            
            if now - before >= mid{
                count += 1
                before  = now
            }
        }
        
        return count
    }



}
