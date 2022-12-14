import UIKit

// Locks

// Защита критической секции для записи, чтения или записи и чтения
// globalProperty - критической секции
class ReadWriteLock {
    private var lock = pthread_rwlock_t()
    private var attribute = pthread_rwlockattr_t()
    
    private var globalProperty: Int = 0
    
    init() {
        pthread_rwlock_init(&lock, &attribute)
    }
    
    var workProperty: Int {
        get {
            pthread_rwlock_wrlock(&lock)
            let temp = globalProperty
            pthread_rwlock_unlock(&lock)
            return temp
        }
        set {
            pthread_rwlock_wrlock(&lock)
            globalProperty = newValue
            pthread_rwlock_unlock(&lock)
        }
    }
}

//deprecated in iOS 10.0:
//class SpinLock {
//    private var lock = OS_SPINLOCK_INIT
//    func some() {
//        OSSpinLockLock(&lock)
//        //do somethink
//        OSSpinLockUnlock(&lock)
//    }
//}


// c iOS 10.0:
class UnfairLock {
    private var lock = os_unfair_lock_s()
    var array = [Int]()
    func method() {
        os_unfair_lock_lock(&lock)
        array.append(1)
        os_unfair_lock_unlock(&lock)
    }
}

// ObjC под капотом используются рекурсивные mutex-ы
class SynchronizedObjC {
    private var lock = NSObject()
    
    var array = [Int]()
    
    func method() {
        objc_sync_enter(lock)
        array.append(1)
        objc_sync_exit(lock)
    }
}
