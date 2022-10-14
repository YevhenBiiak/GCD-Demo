//
//  MainViewController.swift
//  GCD Demo
//
//  Created by Евгений Бияк on 14.10.2022.
//

import UIKit

class MainViewController: UIViewController {

    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
        view.backgroundColor = .secondarySystemBackground
        
        button.addTarget(nil, action: #selector(action), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initButton()
    }
    
    @objc func action() {
        let secondVC = SecondViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    private func initButton() {
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        button.center = view.center
        button.setTitle("Press me", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        view.addSubview(button)
    }

}

