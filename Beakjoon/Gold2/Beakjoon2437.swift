//
//  Beakjoon2437.swift
//  Beakjoon
//
//  Created by 한현규 on 3/11/24.
//

import Foundation



/// 수학적 귀납법
/// S -> 1...S 가능
/// S(0) = true
/// S(n) 모두 가능하다고 가정한다.  1...S(n)까지 모두 만들수 있음
/// S(n+1) -> S(n) + Num[n] ->
/// 1...S(n) 에 모두 Num[n+1] 을 더해준값들을 만들수 있음 ->
/// 1...S(n), Num[n+1]+1...Num[n+1]+S(n)
/// Num[n+1] <= S(n) 이면  1...Num[n+1]+S(n)
/// Num[n+1] > S(n) 이면 1...S(n), Num[n+1]+1...Num[n+1]+S(n)   S(n)+1이 불가능

class Beakjoon2437{
    func main(){
        let n = Int(readLine()!)!
        
        let nums = readLine()!.split(separator: " ")
            .compactMap { Int(String($0))! }
        
        minSum(n, nums)
    }

    func minSum(_ n: Int, _ nums: [Int]){
        let sorted = nums.sorted()
        
        var minSum = 1
        
        for i in 0..<n{
            if minSum < sorted[i]{
                break
            }
            
            minSum += sorted[i]
        }
        
        print(minSum)

    }


}
