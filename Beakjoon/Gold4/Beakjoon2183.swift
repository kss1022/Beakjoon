//
//  Beakjoon2183.swift
//  Beakjoon
//
//  Created by 한현규 on 2/19/24.
//

import Foundation



class Beakjoon2183{

    func main(){
        let n = Int(readLine()!)!
        fillTile(n: n)
    }



    func fillTile(n: Int){
        if n % 2 != 0{
            print("0")
            return
        }
            
        var mem = Array.init(repeating: 0, count: n + 1)
        mem[1] = 1
        mem[2] = 3
        
        for i in stride(from: 4, through: n, by: +2){
            //6부터는 이전꺼의 *2를 해줘야한다.  반대로 했을떄 +2

            mem[i] = mem[i-2] * 3 + 2

            for j in stride(from: 4, to: i, by: +2){
                mem[i] += mem[i-j] * 2
            }            
        }
                
        print("\(mem[n])")
    }

}
