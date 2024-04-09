//
//  Beakjoon10986.swift
//  Beakjoon
//
//  Created by 한현규 on 4/9/24.
//

import Foundation



class Beakjoon10986{
    func main(){
        let n = readLine()!.split(separator: " ")
            .compactMap{ Int(String($0)) }
        
        let m = n[1]
        
        let num = readLine()!.split(separator: " ")
            .compactMap{ Int(String($0)) }
                
        partialSumDivide(num, m)
    }


    //5 3
    //1 2 3 1 2



    func partialSumDivide(_ nums: [Int], _ divide: Int){
        var remains = Array.init(repeating: 0, count: divide)
        
        var sum = 0
        for i in 0..<nums.count{
            sum += nums[i]
            remains[sum % divide] += 1
        }
        
        
        var result = 0
        result += remains[0]
        
        for i in 0..<remains.count{
            result += combination(remains[i])
        }
        
        print(result)
    }

    //nC2
    func combination(_ n: Int) -> Int{
        n * (n - 1) / 2
    }

}
