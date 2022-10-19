//
//  Main2ViewController.swift
//  GCD Demo
//
//  Created by Евгений Бияк on 18.10.2022.
//

import UIKit

class Main2ViewController: UIViewController {
    
    private var button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        initButton()
        button.addTarget(self, action: #selector(action), for: .touchUpInside)
        afterBlock(secconds: 3, queue: .global()) {
            self.showAlert()
            print(Thread.current)
        }
    }
    
    @objc private func action() {
        navigationController?.pushViewController(ConcurrentViewController(), animated: true)
    }
    
    private func afterBlock(secconds: Int, queue: DispatchQueue = DispatchQueue.global(), completion: @escaping () -> Void) {
        queue.asyncAfter(deadline: .now() + .seconds(secconds)) {
            completion()
        }
    }
    
    private func showAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: "Hello", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    private func initButton() {
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        button.center = CGPoint(x: view.center.x, y: view.center.y)
        button.setTitle("Performe concurrent", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        view.addSubview(button)
    }
}
