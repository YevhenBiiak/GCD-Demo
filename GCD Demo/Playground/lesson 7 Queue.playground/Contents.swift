import UIKit

// GCD / Queue > Line / (очереди)

/**** serial queue
thread1   [task1] - [task2] - [task3] - [task4]
-------------------------------------------------------------------> Time
*/

/**** concurrent queue
thread1     [task1]
thread2              [task2]
thread3   [task3]
thread4        [task4]
---------------------------> Time
*/

/**** sync
thread1 -- [task1] -block- [task3] -block- --
thread2 ---------- [task2] ------- [task4] --------
-----------------------------------------------------------> Time
*/

/**** async
thread1 -- [task1] -------- [task1] [task1] -
thread2 [task1] - [task1] ----- [task1] -----
---------------------------------------------------------> Time
*/

/**** main serial queue
main queue - [task1] - [task2] - [task3] - [task4]-
--------------------------------------------------------------------> Time
*/

class QueueTest1 {
    private var serialQueue = DispatchQueue(label: "serialTest")
    private var concurrentQueue = DispatchQueue(label: "concurrentTest", attributes: .concurrent)
}

class QueueTest2 {
    private var globalQueue = DispatchQueue.global()
    private var mainQueue = DispatchQueue.main
}
