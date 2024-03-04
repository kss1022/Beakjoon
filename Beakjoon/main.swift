import Foundation

main()


func main(){
    let n = Int(readLine()!)!
    let nums = readLine()!.split(separator: " ")
        .compactMap { Int(String($0))}
    
    LIS(n, nums: nums)
}

//가장 긴 증가하는 부분 수열
func LIS(_ n : Int, nums: [Int]){
    var sequences = [Int]()
    
    sequences.append(nums[0])
    
    for i in 1..<n{
        if sequences.last! < nums[i]{
            sequences.append(nums[i])
            continue
        }
        
        let insertIndex = searchIndex(nums[i])
        sequences[insertIndex] = nums[i]
    }
    
    print("\(sequences.count)")
    
    
    func searchIndex(_ num: Int) -> Int{
        var start = 0
        var end = sequences.count-1
        
        var index = 0
        
        while start <= end{
            let mid = (start + end) / 2
  
            if sequences[mid] >= num{
                //findLeft
                end = mid-1
                index = mid
                continue
            }
            
            start = mid+1
        }
        
        return index
    }
}


