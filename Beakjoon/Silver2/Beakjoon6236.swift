//
//  Beakjoon6236.swift
//  Beakjoon
//
//  Created by 한현규 on 1/4/24.
//

import Foundation



class Beakjoon6236{
    func run(){
        let nums = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
        
        let n = nums[0]
        let m = nums[1]
        
        
        var moneys = [Int]()
        
        for _ in 0..<n {
            let money = Int(readLine()!)!
            moneys.append(money)
        }
        
        let max = moneys.max()!

        var left = max
        var right = moneys.reduce(0) { $0 + $1 }
        var mid = 0
        
        var result = 0
        
        while left <= right{
            mid = (left + right) / 2
            
            let takeOut = checkPayment(takeOut: mid, moneys: moneys)
            if takeOut > m{
                left = mid + 1 //More
            }else{
                right = mid - 1
                result = mid
            }
        }

        print(result)
    }


    func checkPayment(takeOut : Int, moneys: [Int]) -> Int{
        
        var currentMoney = takeOut
        var count = 1
                
        for money in moneys {
            if currentMoney >= money{
                currentMoney -= money
                continue
            }

            currentMoney = takeOut - money
            count += 1
        }
                
        return count
    }

}
