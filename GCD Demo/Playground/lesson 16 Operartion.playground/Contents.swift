import UIKit

// BlockOpearion, OperationCancel, WaitUntilFinished = (barrier)

let queue = OperationQueue()

// OperationCancel

class OperationCancelTest: Operation {
    override func main() {
        if isCancelled {
            print("isCancelled: ", isCancelled)
            return
        }
        print("test 1")
        sleep(2)
        
        if isCancelled {
            print("isCancelled: ", isCancelled)
            return
        }
        print("test 2")
    }
}

func cancelMethod() {
    let testOperation = OperationCancelTest()
    queue.addOperation(testOperation)
    sleep(1)
    testOperation.cancel()
}

//cancelMethod()
/* prints
     test 1
     isCancelled:  true
*/

// WaitUntilFinished

class WaitOperationTest {
    private let queue = OperationQueue()
    
    func test() {
        queue.addOperation {
            sleep(1)
            print("test 1")
        }
        queue.addOperation {
            sleep(2)
            print("test 2")
        }
        // barrier
        queue.waitUntilAllOperationsAreFinished()
        queue.addOperation {
            print("test 3")
        }
    }
}

let waitOperation = WaitOperationTest()
//waitOperation.test()
/* prints
     test 1
     test 2
     test 3
*/

class WaitOperationTest2 {
    private let operationQueue = OperationQueue()
    
    func test() {
        let operation1 = BlockOperation {
            sleep(2)
            print("test 1")
        }
        let operation2 = BlockOperation {
            sleep(1)
            print("test 2")
        }
        operationQueue.addOperations([operation1, operation2], waitUntilFinished: true)
        operationQueue.addOperation {
            print("test 3")
        }
    }
}

let waitOperation2 = WaitOperationTest2()
//waitOperation2.test()
/* prints
     test 2
     test 1
     test 3
*/

// Operation with completionBlock

class CompletionBlockTest {
    private let operationQueue = OperationQueue()
    
    func test() {
        let operaton1 = BlockOperation {
            print("start work")
            sleep(2)
            print("finish work")
        }
        operaton1.completionBlock = {
            print("completion")
        }
        operationQueue.addOperation(operaton1)
    }
}

let completionBlock = CompletionBlockTest()
completionBlock.test()
