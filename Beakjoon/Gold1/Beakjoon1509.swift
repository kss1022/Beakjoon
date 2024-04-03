//
//  Beakjoon1509.swift
//  Beakjoon
//
//  Created by 한현규 on 4/3/24.
//

import Foundation



class Beakjoon1509{

    func main(){
        let word = readLine()!.compactMap { $0 }
        palindrome(word)
    }

    func palindrome(_ word: [Character]){
        var palindromes = Array.init(
            repeating: Array.init(repeating: false, count: word.count),
            count: word.count
        )

        
        for i in 0..<word.count{
            palindromes[i][i] = true
            for j in (i+1)..<word.count{
                if isPalindrome(word, (i,j)){
                    palindromes[i][j] = true
                }
            }
        }
        
        var mem = Array.init(repeating: -1, count: word.count+1)
        mem[0] = 0
        mem[1] = 1
        for i in 2...word.count{
            mem[i] = mem[i-1] + 1
            for j in 1..<i{
                if !palindromes[j-1][i-1]{
                    continue
                }
                
                if mem[i] > mem[j-1] + 1{
                    mem[i]  = mem[j-1] + 1
                }
            }
        }
        
        

        print(mem[word.count])
    }


    func isPalindrome(_ word: [Character], _ range: (Int, Int)) -> Bool{
        
        var start = range.0
        var end = range.1
        
        while start < end{
            if word[start] != word[end]{
                return false
            }
            
            start += 1
            end -= 1
        }
        
        return true
    }



    struct Range: Hashable{
        let start: Int
        let end: Int
    }


}
