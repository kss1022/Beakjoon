//
//  Beakjoon11867.swift
//  Beakjoon
//
//  Created by 한현규 on 1/3/24.
//

import Foundation



class Beakjoon11867{
    func run(){
        let nums = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
        
        let n = nums[0]
        let m = nums[0]
            
        if n % 2 == 0 || m % 2 == 0{
            print("A")
        }else{
            print("B")
        }
    }

}
