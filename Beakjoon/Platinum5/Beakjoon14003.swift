//
//  Beakjoon14003.swift
//  Beakjoon
//
//  Created by 한현규 on 4/15/24.
//

import Foundation




class Beakjoon14003{
    
    func main(){
        let n = Int(readLine()!)!
        let nums = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        LIS(n, nums)
    }

    func LIS(_ n: Int, _ nums: [Int]){
        
        var sequences = [Int]()
            
        var indexs = Array.init(repeating: 0, count: n)

        
        sequences.append(nums[0])
        indexs[0] = 0
        
        
        for i in 1..<n{
            if sequences.last! < nums[i]{
                
                sequences.append(nums[i])
                indexs[i] = sequences.count-1
                
                continue
            }
            
            let index = searchIndex(sequences, nums[i])
            sequences[index] = nums[i]
            indexs[i] = index
        }
        
        
        var result = [Int]()
        var findIndex = sequences.count-1
        for i in stride(from: n-1, through: 0, by: -1){
            if indexs[i] == findIndex{
                findIndex -= 1
                result.append(nums[i])
            }
        }
            
        print(sequences.count)
        print(result.reversed().map(String.init).joined(separator: " "))
    }


    func searchIndex(_ arr: [Int], _ newElement: Int) -> Int{
        
        var start = 0
        var end = arr.count-1
        
        var index = 0
        
        while start <= end{
            let mid = (start+end) / 2
            
            
            if arr[mid] >= newElement{
                //findLeft
                index = mid
                end = mid-1
                index = mid
                continue
            }
            
            
            start = mid+1
        }
        
        
        return index
    }

}
