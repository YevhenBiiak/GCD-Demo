import UIKit

// Thread
// Operation
// GCD

// Concurrency
// Thread 1: -----------------
// Thread 2: -----------------

// Serial
// Thread 1: - - -- - -  - ---
// Thread 2:  - -  - - -- -   -


// Sync - wait for task completion
// Async - go to next



// UNIX / POSIX

var thread = pthread_t(bitPattern: 0) // cread thread
var attr = pthread_attr_t() // create attribute

pthread_attr_init(&attr) // initialize attribute
pthread_create(&thread, &attr, { pointer in
    print("test")
    return nil
}, nil)

// Thread

var nsthread = Thread {
    print("test ns thread")
}

nsthread.start()
nsthread.isFinished
nsthread.cancel()
nsthread.isCancelled

// хранение данных в словаре
//nsthread.setValuesForKeys(["1": 1])
nsthread.threadDictionary

nsthread.qualityOfService = .background
