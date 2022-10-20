import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: - Operation

/// Operation абстрактный класс предоставляющий код и данный связанные с задачей
/// Operation представляет собой законченную задачу и являеться абстрактным классом, который представляет потоко-безопасную структуру для моделирования состояния операция и  ее приоритета
/// Главное отличие от GCD возможность отмены операции

/* Operation Life Cycle
 - pending(отложенная)         ->  cancelled(отменена)
 - ready(готова к выполнению)  ->  cancelled(отменена)
 - executing(выполняеться)     ->  cancelled(отменена)
 - finished(закончена)
*/

/* Operation
open class Operation : NSObject {
    open var completionBlock: (() -> Swift.Void)?
    open var quality0fService: QualityOfService
    open var name: String?
 
    open func start()
    open func main()
    open func cancel()
 
    open var isCancelled: Bool { get }
    open var isExecuting: Bool { get }
    open var isFinished: Bool { get
    open var iSAsynchronous: Bool { get }
    open var isReady: Bool { get }
}
*/

// MARK: - OperationQueue

/// OperationQueue - операционная очередь. Выполняет свои очереди Operation обьектов на основе их приоритета и готовности. После добавления в операционную очередь операция остаеться в очереди, пока не сообщит, что она завершена

/* OperationQueue
open class OperationQueue: NSObject {
     open class var current: OperationQueue? { get }
     open class var main: OperationQueue { get }
 
     // macConcurrentOperationCount = 1 - serial
     // macConcurrentOperationCount = 2 - concurrent
     public class let defaultMacConcurrentOperationCount: Int
     open var macConcurrentOperationCount: Int
     
     open func addOperation(_ op: Operation)
     open func addOperation(_ op: @escaping () -> Void)
     
     open var operation: [Operation] { get }
     open var operationCount: Int { get }
 
     open func cancelAllOperation()
     open func waitUntilAllOperationAreFinished()
     
     open var isSuspeneded: Bool
}
*/

print("Current thread: ", Thread.current)

let work = {
    print("Start")
    print(Thread.current)
    print("Finish")
}
let queue1 = OperationQueue()
/// сразу переводит в асинхронное выполнение
queue1.addOperation(work)


var string: String?
let concatOperation = BlockOperation {
    string = "The Swift" + " " + "Developers"
    print(Thread.current)
}
concatOperation.start()
print(string)
/* prints
 Current thread: main
 Current thread: main
 Optional("The Swift Developers")
*/


let queue = OperationQueue()
queue.addOperation(concatOperation)
print(string)
/* prints
 Current thread: main
 nil // because async task execution
 Current thread: name = (null)
*/
