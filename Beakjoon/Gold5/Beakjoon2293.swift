//
//  Beakjoon2293.swift
//  Beakjoon
//
//  Created by 한현규 on 2/8/24.
//

import Foundation



class Beakjoon2293{

    func main(){
        let nums = readLine()!.components(separatedBy: .whitespaces)
            .compactMap(Int.init)
        
        let n = nums[0]
        let price = nums[1]
        
        var coins = [Int]()
        
        for _ in 0..<n{
            let coin = Int(readLine()!)!
            coins.append(coin)
        }
        
        coins = coins.filter { $0 <= price }
            .sorted()
        
        coinCombinations(coins: coins, price: price)
    }



    func coinCombinations(coins: [Int], price: Int){
        var mem = Array(
            repeating: Array.init(repeating: 0, count: price+1),
            count: coins.count
        )
        
        
        let firstCoin = coins[0]
        for i in 1...price{
            if i % firstCoin == 0{
                mem[0][i] = 1
            }
        }
        
        
        for i in 1..<coins.count{
            let coin = coins[i]
            
            for j in 1...price{
                var divide = j / coin
                var count = 0
                            
                while divide >= 0{
                    let rest = j - (divide * coin)
                    
                    if rest == 0{
                        count += 1
                        divide -= 1
                        continue
                    }
                    
                    let before = mem[i-1][rest]
                    count += before
                    divide -= 1
                    
                    //Overflow checker
                    if count >= Int(pow(2.0, 31.0)){
                        count = 0
                    }
                }
                
                mem[i][j] = max(count, mem[i-1][j])
            }
        }
        
        let results = mem[coins.count-1][price]
        print("\(results)")
    }

}
