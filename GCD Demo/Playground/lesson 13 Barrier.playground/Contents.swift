import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: - Barrier

/// Задачи, отправленные до барьера, выполняются до завершения, после чего выполняется барьерная задача.
/// После завершения барьерной задачи очередь возвращается к задачам, которые были отправлены после барьера.

var array = [Int]()

for i in 0...9 { array.append(i) }
print(array, "count: \(array.count)")

DispatchQueue.concurrentPerform(iterations: 10) { array.append($0) }
print(array, "count: \(array.count)")

/* print (race condition)
     [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] count: 10
     [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 2, 1, 3, 4, 5, 6, 7, 8, 9] count: 19
*/

class SafeArray<T> {
    private var array: [T] = []
    private let queue = DispatchQueue(label: "dev" ,attributes: [.concurrent])
    
    subscript(index: Int) -> T {
        queue.sync {
            return array[index]
        }
    }
    
    var values: [T] {
        queue.sync {
            return self.array
        }
        
        //var values: [T] = []
        //queue.sync {
        //    values = self.array
        //}
        //return values
    }
    
    func append(_ element: T) {
        queue.async(flags: .barrier) {
            self.array.append(element)
        }
    }
}

var safeArray = SafeArray<Int>()
DispatchQueue.concurrentPerform(iterations: 10) { index in
    safeArray.append(index)
}
print(safeArray.values)
print("element at index 2 is", safeArray[2])
/* prints
     [2, 0, 1, 6, 5, 3, 4, 7, 8, 9]
     element at index 2 is 1
*/
