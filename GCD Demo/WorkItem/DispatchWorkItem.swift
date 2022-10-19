//
//  DispatchWorkItem.swift
//  GCD Demo
//
//  Created by Евгений Бияк on 18.10.2022.
//

import Foundation

class DispatchWorkItem1 {
    private let queue = DispatchQueue(label: "DispatchWorkItem1", attributes: [.concurrent])
    
    func start() {
        let workItem = DispatchWorkItem {
            print("-------- Start task --------")
            print(Thread.current)
            sleep(1)
        }
        
        workItem.notify(queue: .main) {
            print("Task is finished")
            print(Thread.current)
        }
        
        queue.async(execute: workItem)
    }
}

class DispatchWorkItem2 {
    private let queue = DispatchQueue(label: "DispatchWorkItem2")
    
    func start() {
        queue.async {
            print("-------- Start task --------")
            print(Thread.current)
            sleep(1)
        }
        
        queue.async {
            print("start task 2")
            print(Thread.current)
            sleep(1)
        }
        
        let workItem = DispatchWorkItem {
            print("start work item task")
            print(Thread.current)
        }
        
        queue.async(execute: workItem)
        /// Cancellation does not affect the execution of a work item that has already begun
        /// workItem won't be executed because it hasn't started yet
        workItem.cancel()
    }
}
