//
//  ConcurrentViewController.swift
//  GCD Demo
//
//  Created by Евгений Бияк on 18.10.2022.
//

import UIKit

class ConcurrentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        
        /// concurrent including main queue
        ///
        //DispatchQueue.concurrentPerform(iterations: 200_000) { i in
        //    print("\(i) times")
        //    print(Thread.current)
        //}
        
        /// concurrent excluding main queue
        ///
        //let queue = DispatchQueue.global(qos: .utility)
        //queue.async {
        //    DispatchQueue.concurrentPerform(iterations: 200_000) { i in
        //        print("\(i) times")
        //        print(Thread.current)
        //    }
        //}
        
        /// managed queue
        ///
        myInactiveQueue()
        
    }

    private func myInactiveQueue() {
        // by default is serial queue
        // initiallyInactive means that the newly created queue is inactive.
        let inactiveQueue = DispatchQueue(label: "The developer", attributes: [.concurrent, .initiallyInactive])
        
        inactiveQueue.async {
            print("Done!")
        }
        
        print("not yet started...")
        inactiveQueue.activate()
        print("activate")
        inactiveQueue.suspend()
        print("Pause!")
        inactiveQueue.resume()
    }
}
