import Foundation

func insertIionSort(_ array: inout Array<Int>){
    if array.count <= 1 {
        return;
    }
    for i in 1..<array.count{
        let newItem = array[i];
        var j = i;
        while (j > 0 && array[j-1] > newItem){
            //두번째 조건이라면
            array[j] = array[j-1]
            j -= 1
        }
        array[j] = newItem
    }
}
