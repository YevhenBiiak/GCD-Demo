import UIKit
import PlaygroundSupport

// Dispatch Semaphore
/// Тоже самое что и мьютекс только счетчик потоков может быть больше чем одни.
/// Ограничивает доступ для потоков, блокируя доступ, если указанное число потоков уже работает с обьектом
/// Semaphore - counter
/// signal() - increment
/// wait() - decrement
/// Calls to signal() must be balanced with calls to wait()

let queue = DispatchQueue(label: "developer", attributes: [.concurrent])

// Передача нуля полезна, когда двум потокам необходимо согласовать завершение определенного события.
// Передача значения больше нуля полезна для управления конечным пулом ресурсов, где размер пула равен значению.
let semaphore1 = DispatchSemaphore(value: 1)

queue.async {
    semaphore1.wait() // value - 1
    sleep(1)
    print("semaphore 1 task 1")
    semaphore1.signal() // value + 1
}
queue.async {
    semaphore1.wait() // value - 1
    sleep(1)
    print("semaphore 1 task 2")
    semaphore1.signal() // value + 1
}
queue.async {
    semaphore1.wait() // value - 1
    sleep(1)
    print("semaphore 1 task 3")
    semaphore1.signal() // value + 1
}

let semaphore2 = DispatchSemaphore(value: 2)

queue.async {
    semaphore2.wait() // value - 1
    sleep(1)
    print("semaphore 2 task 1")
    semaphore2.signal() // value + 1
}
queue.async {
    semaphore2.wait() // value - 1
    sleep(1)
    print("semaphore 2 task 2")
    semaphore2.signal() // value + 1
}
queue.async {
    semaphore2.wait() // value - 1
    sleep(1)
    print("semaphore 2 task 3")
    semaphore2.signal() // value + 1
}

let semaphore = DispatchSemaphore(value: 2)

DispatchQueue.concurrentPerform(iterations: 10) { id in
    semaphore.wait(timeout: DispatchTime.distantFuture)
    print("Block", id)
    semaphore.signal()
}

class SemaphoreTest {
    private let semaphore = DispatchSemaphore(value: 2)
    private var array = [Int]()
    
    private func work(_ id: Int) {
        semaphore.wait()
        array.append(2)
        print("test. array count: ", array.count)
        Thread.sleep(forTimeInterval: 2)
        semaphore.signal()
    }
    
    func startAllThreads() {
        DispatchQueue.global().async {
            self.work(111)
            print(111, Thread.current)
        }
        DispatchQueue.global().async {
            self.work(222)
            print(222, Thread.current)
        }
        DispatchQueue.global().async {
            self.work(333)
            print(333, Thread.current)
        }
    }
}

let semTest = SemaphoreTest()
semTest.startAllThreads()
