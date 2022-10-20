import UIKit

// NSCondition (Condition) - условия для потоков

var available = false
var condition = pthread_cond_t()
var mutex = pthread_mutex_t()

class ConditionMutexPrinter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        printerMethod()
    }
    
    private func printerMethod() {
        print("PRINTER ENTER")
        defer {
            available = false
            pthread_mutex_unlock(&mutex)
            print("PRINTER EXIT")
        }
        
        pthread_mutex_lock(&mutex)
        
        while !available {
            pthread_cond_wait(&condition, &mutex)
        }
    }
}

class ConditionMutexWriter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        writerMethod()
    }
     
    private func writerMethod() {
        print("WRITER ENTER")
        
        defer {
            available = true
            pthread_cond_signal(&condition)
            pthread_mutex_unlock(&mutex)
            print("WRITER EXIT")
        }
        
        pthread_mutex_lock(&mutex)
    }
}

let condPrinter = ConditionMutexPrinter()
let condWriter = ConditionMutexWriter()

//condPrinter.start()
//condWriter.start()


// ------------- in Swift --------------

let nsCondition = NSCondition()
var nsAvailable = false

class NSConditionPrinter: Thread {
    
    override func main() {
        printerMethod()
    }
    
    private func printerMethod() {
        print("PRINTER ENTER")
        defer {
            nsAvailable = false
            nsCondition.unlock()
            print("PRINTER EXIT")
        }
        
        nsCondition.lock()
        
        while !nsAvailable {
            nsCondition.wait()
        }
    }
}

class NSConditionWriter: Thread {
    
    override func main() {
        writerMethod()
    }
    
    private func writerMethod() {
        print("WRITER ENTER")
        
        defer {
            nsAvailable = true
            nsCondition.signal()
            nsCondition.unlock()
            print("WRITER EXIT")
        }
        
        nsCondition.lock()
    }
}

let nsConditionPrinter = NSConditionPrinter()
let nsConditionWriter = NSConditionWriter()

nsConditionPrinter.start()
nsConditionWriter.start()

// lock() - Пытается получить блокировку, блокируя выполнение потока до тех пор, пока блокировка не будет получена. Приложение защищает критический раздел кода, требуя от потока получения блокировки перед выполнением кода.

// unlock() - Как только критическая секция завершена, поток снимает блокировку, вызывая

// wait() - Блокирует текущий поток до тех пор, пока условие не будет просигнализировано. Вы должны заблокировать приемник перед вызовом этого метода.

// signal() - Сигнализирует условие, пробуждая один поток, ожидающий его.


