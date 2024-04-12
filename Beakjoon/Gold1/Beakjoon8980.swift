//
//  Beakjoon8980.swift
//  Beakjoon
//
//  Created by 한현규 on 4/12/24.
//

import Foundation



class Beakjoon8980{

    func main(){
        let nums = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let n = nums[0]
        let capacity = nums[1]
        
        var sends = Array.init(
            repeating: [(Int, Int)](),
            count: n
        )
        
        for _ in 0..<Int(readLine()!)!{
            let send = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            sends[send[0]-1].append( (send[1]-1,send[2]) )
        }
        
        for i in 0..<sends.count{
            sends[i] = sends[i].filter({ $0.0 > i })
        }
        sendBoxs(n, capacity, sends)
    }


    func sendBoxs(_ n: Int, _ max: Int, _ sends: [[(Int, Int)]]){
        var filled = Array.init(
            repeating: 0,
            count: n
        )
        
        var result = 0
        sendBoxRecursive(0, 0)
        print(result)
        
        func sendBoxRecursive(_ deepth: Int, _ capacity: Int){
            if deepth ==  n{
                return
            }
            
            let pullDownedCapacity =  pullDownBoxs(capacity, deepth)
            let loadedCapacity = loadBoxs(pullDownedCapacity, deepth)
            sendBoxRecursive(deepth+1, loadedCapacity)
        }

        
        func pullDownBoxs(_ capacity:  Int, _ town: Int) -> Int{
            var newCapacity = capacity
            newCapacity -= filled[town]  //fill
            filled[town] = 0    //capacity
            return newCapacity
        }

        func loadBoxs(_ capacity: Int, _ town: Int) -> Int{
            var newCapacity = capacity
                        
            for send in sends[town]{
                let to = send.0
                var boxs = send.1
                
                
                while boxs > 0 && newCapacity < max{
                    boxs -= 1
                    filled[to] += 1 //fill
                    newCapacity += 1 //capacity
                    result += 1 //result
                }

                
                
                for i in stride(from: n-1, to: to, by: -1){
                    while filled[i] > 0 && boxs > 0{
                        boxs -= 1
                        filled[to] += 1
                        filled[i] -= 1
                    }
                }

            }
            
            
            return newCapacity
        }
    }

}
