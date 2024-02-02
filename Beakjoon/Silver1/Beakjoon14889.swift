//
//  Beakjoon14889.swift
//  Beakjoon
//
//  Created by 한현규 on 1/15/24.
//

import Foundation


class Beakjoon14889{

    func main(){
        let n = Int(readLine()!)!
        
        var synergys = [[Int]]()
        
        
        for _ in 0..<n{
            let row = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
            synergys.append(row)
        }
        
        let minDiff = minOverallDiff(n: n, synergys: synergys)
        print("\(minDiff)")
    }


    func minOverallDiff(n: Int, synergys: [[Int]]) -> Int{

        
        //combination
        var combis = [[Int]]()
        let nums = Array((1...n))
        combination(nums: nums, combi: [], index: 0, result: &combis)
        
        var minDiff = Int.max
            
        for combi in combis {
            var homeScore = 0
            var awayScore = 0
            
            var isTeamHome = Array(repeating: false, count: n)
            combi.forEach {
                isTeamHome[$0-1] = true
            }
            
            
            for i in 0..<n{
                for j in (i+1)..<n{
                    if isTeamHome[i] && isTeamHome[j]{
                        homeScore += synergys[i][j] + synergys[j][i]
                    }else if !isTeamHome[i] && !isTeamHome[j]{
                        awayScore += synergys[i][j] + synergys[j][i]
                    }
                }
            }
                    
            let diff = abs(homeScore - awayScore)
            minDiff = min(minDiff, diff)
        }
                
        return minDiff
    }



    func combination(nums: [Int], combi: [Int], index: Int, result: inout [[Int]]){
        if combi.count == (nums.count / 2){
            result.append(combi)
            return
        }
        
        
        for i in index..<nums.count{
            var new = combi
            new.append(nums[i])
            combination(nums: nums, combi: new, index: i+1, result: &result)
        }
    }
}
