//
//  Beakjoon1024.swift
//  Beakjoon
//
//  Created by 한현규 on 1/4/24.
//

import Foundation


class Beakjoon1024{    
    /// 18 3
    /// a + (a+1) = 2a + 1    (18 - 1) % 2 != 0
    /// a + (a+1) + (a+2) = 3a + 3   (18 - 3) % 3 == 0
    ///
    ///
    /// avaliable:  N - ( 0...l-1) % l == 0
    /// start : N - ( 0...l-1) / l

    func run(){
        let nums = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
        
        let n = nums[0] //  N <= 1,000,000,000
        let l = nums[1] //  2 < l < 100
            
        var length = l
        while length <= 100{
            if checkLength(n: n, l: length){
                return
            }
            
            length += 1
        }
        
        
        print(-1)
    }


    func checkLength(n: Int, l: Int) -> Bool{
        var sum = n
        sum -= (l-1) * l / 2
        
        let remain = sum % l
        let divide = sum / l
        let avaliable = (remain == 0) && (divide >= 0)
        
        if avaliable{
            printStartToCount(start: divide, count: l)
            return true
        }
        
        
        return false
    }



    func printStartToCount(start: Int, count: Int){
        var strToCount = "\(start)"
        
        for i in 1..<count{
            strToCount += " \(i+start)"
        }
        
        print(strToCount)
    }

}
