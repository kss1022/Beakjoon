//
//  Beakjoon1700.swift
//  Beakjoon
//
//  Created by 한현규 on 3/28/24.
//

import Foundation



class Beakjoon1700{
    func main(){
        let nums = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let hole =  nums[0]
        
        let plugs = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }

        removePlugs(hole, plugs)
    }

    func removePlugs(_ hole: Int, _ plugs: [Int]){
        var uses = Set<Int>()
        print(removePlugsRecursive(0, &uses, hole, plugs, 0))
    }



    func removePlugsRecursive(_ deepth: Int, _ uses: inout Set<Int>, _ hole: Int,_ plugs: [Int], _ count: Int) -> Int{
        if deepth == plugs.count{
            return count
        }
        
        if uses.count < hole{
            uses.insert(plugs[deepth])
            return removePlugsRecursive(deepth+1, &uses, hole, plugs, count)
        }
        
        
        //new plug already uses
        if uses.contains(plugs[deepth]){
            return removePlugsRecursive(deepth+1, &uses, hole, plugs, count)
        }
        
        //find latest plug
        var nextIndexs = [Int: Int]()
        uses.forEach{ plug in
            nextIndexs[plug] = Int.max
            for i in deepth..<plugs.count{
                if plugs[i] == plug{
                    nextIndexs[plug] = i
                    break
                }
            }
        }
            
        let latestPlug = nextIndexs.max { $0.value < $1.value }!.key
        uses.remove(latestPlug)
        uses.insert(plugs[deepth])
        return removePlugsRecursive(deepth+1, &uses, hole, plugs, count+1)
    }

}
