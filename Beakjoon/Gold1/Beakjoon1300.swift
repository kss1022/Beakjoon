//
//  Beakjoon1300.swift
//  Beakjoon
//
//  Created by 한현규 on 1/12/24.
//

import Foundation



class Beakjoon1300{
    func main(){
        let n = Int(readLine()!)!
        let k = Int(readLine()!)!
        
        var low = 1
        var high = k
        
        var mid = (low + high) / 2
                
        var result = 0
        
        while low <= high{
            mid = (low + high) / 2
            
            var sum = 0
            for i in 1...n{
                //각 row에서 mid보다 작은 값 -> mid / i 값임!
                sum += min(n,  mid / i)
            }
                
            if sum >= k{
                //mid보다 작은 값들이 더 많으니까 밑에꺼를 탐색
                result = mid
                high = mid - 1
            }else{
                //mid보다 작은 값들이 더 적으니 위에꺼를 탐색
                low = mid + 1
            }
        }
             
        
        print("\(result)")
    }
}
