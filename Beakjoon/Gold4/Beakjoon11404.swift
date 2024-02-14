//
//  Beakjoon11404.swift
//  Beakjoon
//
//  Created by 한현규 on 2/14/24.
//

import Foundation


class Beakjoon11404{
    
    func main(){
        let nCity = Int(readLine()!)!
        let nBus = Int(readLine()!)!
        
        
        var buses = [(Int,Int,Int)]()
        for _ in 0..<nBus{
            let bus = readLine()!.split(separator: " ")
                .map(String.init)
                .compactMap(Int.init)
            buses.append((bus[0]-1,bus[1]-1,bus[2]))
        }
        
        
        floyd(city: nCity, bus: nBus, buses: buses)
    }



    //Floyd-Warshall
    func floyd(city: Int, bus: Int, buses: [(Int,Int,Int)]){
        var distances = Array.init(
            repeating: Array.init(repeating: Int.max, count: city),
            count: city
        )
        
        for i in 0..<city{
            distances[i][i] = 0
        }
        
        
        for bus in buses{
            distances[bus.0][bus.1] = min(distances[bus.0][bus.1], bus.2)
        }
            

        for m in 0..<city{  //mid
            for s in 0..<city{
                for e in 0..<city{
                    if distances[s][m] == Int.max || distances[m][e] == Int.max{
                        continue
                    }
                    
                    let newDistance = distances[s][m] + distances[m][e]
                    
                    // s->e >  s->m + m->e
                    if distances[s][e] > newDistance{
                        distances[s][e] = newDistance
                    }
                }
            }
        }
        
        
        distances.forEach { distance in
            let row = distance
                .map{ num -> Int in
                    if num == Int.max{
                        return 0
                    }
                    return num
                }
                .map(String.init)
                .joined(separator: " ")
            print(row)
        }
        
    }


}
