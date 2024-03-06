//
//  Beakjoon1202.swift
//  Beakjoon
//
//  Created by 한현규 on 3/7/24.
//

import Foundation


class Beakjoon1202{
    
    func main(){        
        let nums = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        let N = nums[0]
        let K = nums[1]
        
        var products =  [(weight: Int, price: Int)]()
        for _ in 0..<N{
            let product = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            products.append((product[0], product[1]))
        }
        
        var backPacks = [Int]()
        for _ in 0..<K{
            let backPack = Int(readLine()!)!
            backPacks.append(backPack)
        }
        
        products.sort { $0.weight < $1.weight }
        backPacks.sort()
        
        var result = 0
        var i = 0
        var queue = PriorityQueue<Int>(ascending: false)
        for backPack in backPacks {
            while i < N && products[i].weight <= backPack{
                queue.push(products[i].price)
                i += 1
            }
            
            if !queue.isEmpty{
                result += queue.pop()!
            }
        }
        
        print(result)
    }

}
