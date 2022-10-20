import UIKit

// NSRecutsiveLock - для рекурсивных методов

var array: [Int] = []

class RecursiveMutexTest {
    private var mutex = pthread_mutex_t()
    private var attribute = pthread_mutexattr_t()

    init() {
        pthread_mutexattr_init(&attribute)
        pthread_mutexattr_settype(&attribute, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&mutex, &attribute)
    }

    func firtsMethod() {
        pthread_mutex_lock(&mutex)
        defer {
            pthread_mutex_unlock(&mutex)
        }
        array.append(1)
        secondMethod()
    }

    private func secondMethod() {
        pthread_mutex_lock(&mutex)
        defer {
            pthread_mutex_unlock(&mutex)
        }
        array.append(2)
    }
}

let recutsive = RecursiveMutexTest()
recutsive.firtsMethod()
print(array)

// in swift

array = []

let recursiveLock = NSRecursiveLock()

class RecursiveThread: Thread {
    
    override func main() {
        recursiveLock.lock()
        array.append(1)
        method()
        recursiveLock.unlock()
        print("end main")
    }
    
    private func method() {
        recursiveLock.lock()
        array.append(2)
        recursiveLock.unlock()
        print("end method")
    }
}

let thread = RecursiveThread()

// запустиить поток
thread.start()

while !thread.isFinished {}

print(array)

// рекомендуют делать thread.cancel вместо thread.exit()
//thread.cancel()
