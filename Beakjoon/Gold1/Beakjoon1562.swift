//
//  Beakjoon1562.swift
//  Beakjoon
//
//  Created by 한현규 on 4/2/24.
//

import Foundation



final class Beakjoon1562{
    

    func main(){
        let n = Int(readLine()!)!
        stairsNums(n, 1000000000)
    }


    //ex) uses : bit
    //use 0 : 0000000001
    //use 9 : 1000000009

    func stairsNums(_ N: Int, _ divisor: Int){
        
        let allUses = (1 << 10) - 1
        
        //[num][e][uses]
        var mem = Array.init(
            repeating: Array.init(
                repeating: Array.init(repeating: -1, count: (1 << 10)),
                count: N+1
            ),
            count: 10
        )

        var result = 0
        for i in 1...9{
            result += stairsNumRecursive(i, N-1, appendUses(0, i))
            result %= divisor
        }
        
        print(result)
      
        
        func stairsNumRecursive(_ num: Int, _ e: Int, _ uses: Int) -> Int{
            if mem[num][e][uses] != -1{
                return mem[num][e][uses]
            }
            
            if e == 0{
                return uses == allUses ? 1 : 0
            }
                    
            var count = 0
            
            let top = num+1
            if top <= 9{
                count += stairsNumRecursive(top, e-1, appendUses(uses, top)) % divisor
            }
            
            let bottom = num-1
            if bottom >= 0{
                count += stairsNumRecursive(bottom, e-1, appendUses(uses, bottom)) % divisor
            }
        
            mem[num][e][uses] = count % divisor
            return mem[num][e][uses]
        }
        

        func appendUses(_ uses: Int, _ num: Int) -> Int{
            let mask =  1 << num
            return uses | mask
        }
        

    }

}
