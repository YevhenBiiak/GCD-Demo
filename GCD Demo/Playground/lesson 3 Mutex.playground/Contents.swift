import UIKit

// Synchronization & Mutex

// Synchronization - Синхронизация одновременной работы с обьектом (например добавление и чтение с массивом) в разных потоках. Т.е. постановка задачи в очередь

// Mutex - защита обьекта от доступа к нему с другого потока отличного от того который завладел мьютексом. В один момент только один поток может владеть мьютексом. Если мьютекс занят то другой поток обратившийся к обьекту засыпает и ждет

class SafeThread {
    private var mutex = pthread_mutex_t()
    
    init() {
        pthread_mutex_init(&mutex, nil)
    }
    
    func someMethod(completion: () -> Void) {
        pthread_mutex_lock(&mutex)
        // some thread safe work with data
        completion()
        
        // освобождение должно быть обязательно потому что мьютекс не отпустит обьект
        defer {
            pthread_mutex_unlock(&mutex)
        }
    }
}

var array: [String] = []

let safeThread = SafeThread()

safeThread.someMethod {
    print("test")
    array.append("1 thread")
}

array.append("2 thread")

// in swift

class SafeNSThread {
    private let mutex = NSLock()
    
    func someMethod(completion: () -> Void) {
        mutex.lock()
        // some thread safe work with data
        completion()
        
        // освобождение должно быть обязательно потому что мьютекс не отпустит обьект
        defer {
            mutex.unlock()
        }
    }
}
