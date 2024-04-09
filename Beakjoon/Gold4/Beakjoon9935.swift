//
//  Beakjoon9935.swift
//  Beakjoon
//
//  Created by 한현규 on 4/9/24.
//

import Foundation



class Beakjoon9935{
    
    func main(){
        let str = readLine()!
        let bomb = readLine()!
        stringBomb(str, bomb)
    }


    func stringBomb(_ str: String, _ bomb: String){

        var stack: [Character] = str.reversed()
        let bomb = bomb.compactMap { $0 }
        
        var result = [Character]()
                
        while !stack.isEmpty{
            let pop = stack.removeLast()
            result.append(pop)
            
            if isBomb(&result, bomb){
                for i in 0..<bomb.count{
                    result.removeLast()
                }
            }
        }
        
        if result.isEmpty{
            print("FRULA")
            return
        }
        
        print(result.compactMap{ String($0) }.joined())
    }


    func isBomb(_ result: inout [Character], _ bomb: [Character]) -> Bool{
        if result.count < bomb.count{
            return false
        }
        
        
        for i in 0..<bomb.count{
            if result[result.count-1-i] != bomb[bomb.count-1-i]{
                return false
            }
        }
        
        return true
    }





    //    let remain = stringBombRecursive(str.compactMap{ $0 }, bomb.compactMap{ $0 })
    //
    //
    //    if remain.isEmpty{
    //        print("FRULA")
    //        return
    //    }
    //
    //    print(remain)


    //func stringBombRecursive(_ str: [Character], _ bomb: [Character]) -> String{
    //    var i = 0
    //
    //    var isChange = false
    //
    //    var temp = str
    //
    //    while true{
    //        if (i + bomb.count - 1) >= temp.count{
    //            break
    //        }
    //
    //        if isBomb(temp, bomb, i){
    //            removeRange(&temp, range: (i, i+bomb.count-1))
    //            isChange = true
    //            i += bomb.count-1
    //            continue
    //        }
    //
    //        i += 1
    //    }
    //
    //
    //    if isChange{
    //        return stringBombRecursive(temp.filter({ $0 != " "}), bomb)
    //    }
    //
    //    return temp.compactMap{ String($0) }
    //        .joined()
    //}
    //
    //
    //
    //func isBomb(_ str: [Character], _ bomb: [Character], _ start: Int) -> Bool{
    //    for i in 0..<bomb.count{
    //        if str[start+i] != bomb[i]{
    //            return false
    //        }
    //    }
    //
    //
    //    return true
    //}
    //
    //
    //
    //
    //func removeRange(_ str: inout [Character], range: (Int, Int)){
    //    for i in range.0...range.1{
    //        str[i] = " "
    //    }
    //}
    //

}
