//
//  Beakjoon1786.swift
//  Beakjoon
//
//  Created by 한현규 on 4/18/24.
//

import Foundation




class Beakjoon1786{
    func main(){
        let T = readLine()!.compactMap{ $0 }
        let P = readLine()!.compactMap{ $0 }
        KMP(T, P)
    }


    func KMP(_ str: [Character], _ patter: [Character]){
        let table = piTable(patter)
        
        
        var j = 0
        var result = [Int]()
        
        for i in 0..<str.count{
            while j > 0 && str[i] != patter[j]{
                j = table[j-1]
            }
            
            if str[i] == patter[j]{
                j += 1
                
                if j == patter.count{
                    result.append(i-j+2)
                    j = table[j-1]
                }
            }
        }
        
        print(result.count)
        print(result.map(String.init).joined(separator: " "))
    }

    //print(piTable("ababbab".compactMap{ $0 }))
    func piTable(_ arr: [Character]) -> [Int]{
        var pi = Array.init(repeating: 0, count: arr.count)
        
        var k = 0
        for j in 1..<arr.count{
            while k > 0 && arr[j] != arr[k]{
                k = pi[k-1]
            }
            
            
            if arr[j] == arr[k]{
                k += 1
            }
            pi[j] = k
        }
        
        return pi
    }

}
