//
//  Beakjoon1947.swift
//  Beakjoon
//
//  Created by 한현규 on 4/11/24.
//

import Foundation



class Beakjoon1947{
 
    func main(){
        let n = Int(readLine()!)!
        sendPresent(n, 1000000000)  //10^10
    }

    ///P(n)
    ///P(1) = 0
    ///P(2) = 1
    ///P(3) = 2     (2, 3, 1) , (3, 1 , 2)
    ///
    /// P(n)
    ///
    /// P(n-1) 에서 한명을 골라서 그사람과 선물 주고받기 -> P(n-1) * (n-1)
    /// n-1명에서 n-2명을 다르게 주고 받음 -> 남은 1명과 주고 받기 P(n-2) * n-1
    /// P(n) = (n-1) * ( P(n-1) + P(n-2) )


    func sendPresent(_ n : Int, _ divide: Int){
        if n == 1{
            print(0)
            return
        }
        
        
        var mem = Array.init(repeating: -1, count: n+1)
        mem[0] = 0
        mem[1] = 0
        mem[2] = 1
        
        for i in stride(from: 3, through: n, by: 1){
            mem[i] = ( (i-1) * ((mem[i-1] + mem[i-2]) % divide) )  % divide
        }
        
        print(mem[n])
    }

}
