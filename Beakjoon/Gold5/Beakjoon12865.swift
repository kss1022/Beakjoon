//
//  Beakjoon12865.swift
//  Beakjoon
//
//  Created by 한현규 on 2/2/24.
//

import Foundation



class Beakjoon12865{
    func main(){
        let terms = readLine()!.components(separatedBy: .whitespaces)
            .compactMap(Int.init)
        
        let n = terms[0]
        let k = terms[1]
        
        
        var items = [Item]()
        
        for _ in 0..<n{
            let item = readLine()!.components(separatedBy: .whitespaces)
                .compactMap(Int.init)
            
            items.append(Item(weight: item[0], value: item[1]))
        }
        
        let maxValue = maxValues(n: n, k: k, items: items)
        print(maxValue)
    }



    func maxValues(n : Int, k : Int, items: [Item]) -> Int{
        
        var mem = Array.init(
            repeating: Array.init(repeating: 0, count: k+1),
            count: n
        )
        
        
        for i in 1...k{
            if i < items[0].weight{
                continue
            }
            
            mem[0][i] = items[0].value
        }
        
        
        for i in 1..<n{
            for j in 1...k{
                if j < items[i].weight{
                    mem[i][j] = mem[i-1][j]
                    continue
                }

                
                let remainWeight = j - items[i].weight
                let remainMax = mem[i - 1][remainWeight]
                
                let choice1 = mem[i-1][j]
                let choice2 = remainMax + items[i].value

                mem[i][j] = max(choice1, choice2)
            }
        }
        
        
        
        return mem[n-1][k]
    }


    struct Item{
        let weight: Int
        let value: Int
    }

}
