//
//  Beakjoon1107.swift
//  Beakjoon
//
//  Created by 한현규 on 4/9/24.
//

import Foundation



class Beakjoon1107{
    
    func main(){
        let channel = Int(readLine()!)!
        let breakdownCount = Int(readLine()!)!
        
        let breakdowns = breakdownCount == 0 ? [] : readLine()!
            .split(separator: " ")
            .compactMap { Int(String($0)) }
                        
        moveChannel(100, channel, breakdowns)
    }



    func moveChannel(_ start: Int, _ dest: Int, _ breakdowns: [Int]){
        
        let numbers = getNumbers(breakdowns)
        
        if numbers.isEmpty{
            print(startToDest(start, dest))
            return
        }
        
        print(nearestToDest(dest, numbers, startToDest(start, dest)))
    }

    func getNumbers(_ breakdowns: [Int]) -> [Int]{
        var numbers = Array.init(repeating: true, count: 10)   // 0 ~ 9
        for breakdown in breakdowns {
            numbers[breakdown] = false
        }
        return numbers.enumerated().filter { $0.element }
            .map { $0.offset }
    }

    func startToDest(_ start: Int, _ dest: Int) -> Int{
        abs(dest - start)
    }

    func nearestToDest(_ num: Int , _ numbers: [Int], _ startToDest: Int) -> Int{
        var result = startToDest
        getNearestNumRecursive(0, 0, num, numbers, numberSize(num)+1, &result)
        return result
    }


    func getNearestNumRecursive(_ deepth: Int, _ num: Int, _ to: Int,_ numbers: [Int], _ e: Int, _ result: inout Int){
        if deepth != 0{
            let current = abs(to - num) + numberSize(num)
            result = min(current, result)
        }
        
        if deepth == e{
            return
        }
        
        
        for n in numbers{
            let newNum = num + n * Int(pow(10.0, Double(deepth)))
            getNearestNumRecursive(deepth+1, newNum, to, numbers, e, &result)
        }
    }


    func numberSize(_ num: Int) -> Int{
        var result = 0
        
        var temp = num
        
        while true{
            if temp / 10 == 0{
                result += 1
                break
            }
            
            result += 1
            temp /= 10
        }
        
        return result
    }

}
