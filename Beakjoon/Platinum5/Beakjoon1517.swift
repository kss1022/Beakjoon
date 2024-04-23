//
//  Beakjoon1517.swift
//  Beakjoon
//
//  Created by 한현규 on 4/23/24.
//

import Foundation



class Beakjoon1517{

    func main(){
        let n = Int(readLine()!)!
        let nums = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        bubbleSortSwapedCount(n, nums)
    }

    //N(1 ≤ N ≤ 500,000)
    //0 ≤ |A[i]| ≤ 1,000,000,000
    func bubbleSortSwapedCount(_ n: Int, _ nums: [Int]){
        _ = mergeSortRecursive(nums)
        print(sums)
    }


    var sums = 0

    func mergeSortRecursive(_ nums : [Int]) -> [Int]{
        if nums.count < 2{
            return nums
        }
        
        let mid = nums.count/2
        let left = mergeSortRecursive(Array(nums[0..<mid]))
        let right = mergeSortRecursive(Array(nums[mid..<nums.count]))
        
        return merge(left, right)
    }

    func merge(_ leftArr: [Int], _ rightArr: [Int]) -> [Int]{
        
        var result = [Int]()
        var leftIndex = 0
        var rightIndex = 0
        
        
        while leftIndex < leftArr.count && rightIndex < rightArr.count{
            if leftArr[leftIndex] <= rightArr[rightIndex]{
                result.append(leftArr[leftIndex])
                leftIndex += 1
            }else{
                result.append(rightArr[rightIndex])
                rightIndex += 1
                sums += (rightIndex+leftArr.count)-result.count     //right index moved count
            }
        }
        
        
        while leftIndex < leftArr.count{
            result.append(leftArr[leftIndex])
            leftIndex += 1
        }
        
        while rightIndex < rightArr.count{
            result.append(rightArr[rightIndex])
            rightIndex += 1
        }
        
        return result
    }

}
