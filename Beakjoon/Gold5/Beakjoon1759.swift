//
//  Beakjoon1759.swift
//  Beakjoon
//
//  Created by 한현규 on 2/5/24.
//

import Foundation


class Beakjoon1759{
    func main(){
        let inputs = readLine()!.components(separatedBy: .whitespaces)
            .compactMap(Int.init)
        
        let length = inputs[0]
        
        let charaters = readLine()!.components(separatedBy: .whitespaces)
            .compactMap { Character($0) }
        
        codes(charaters: charaters, length: length)
    }


    func codes(charaters: [Character], length: Int){
        let charaters = charaters.sorted()
        
        
        var resutls = [[Character]]()
        
        codesRecursive(
            charaters: charaters,
            length: length,
            results: &resutls,
            codes: [],
            index: 0
        )
                
        resutls.map { charaters in
            charaters.map(String.init).joined()
        }.forEach {
            print($0)
        }
    }


    func codesRecursive(
        charaters: [Character],
        length: Int,
        results: inout [[Character]],
        codes: [Character],
        index: Int
    ){
        if codes.count == length && checkCounts(characters: codes){
            results.append(codes)
            return
        }
        
        
        for i in index..<charaters.count{
            var newCode = codes
            newCode.append(charaters[i])
            codesRecursive(
                charaters: charaters,
                length: length,
                results: &results,
                codes: newCode,
                index: i+1
            )
        }
        
    }

    //a, e, i, o, u
    func checkCounts(characters:  [Character]) -> Bool{
        let vowels: [Character] = ["a", "e", "i", "o", "u"]
        
        var vowelCount = 0
        var consonantCount = 0
        
        for character in characters {
            if vowels.contains(where: { $0 == character }){
                vowelCount += 1
            }else{
                consonantCount += 1
            }
            
            if vowelCount >= 1 && consonantCount >= 2{
                return true
            }
        }
        
        return false
    }

}
