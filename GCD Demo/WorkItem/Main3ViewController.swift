//
//  Main3ViewController.swift
//  GCD Demo
//
//  Created by Евгений Бияк on 18.10.2022.
//

import UIKit

class Main3ViewController: UIViewController {
    
    private let workItem1Button = UIButton()
    private let workItem2Button = UIButton()
    private let imageDemoButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        
        workItem1Button.addTarget(nil, action: #selector(actionButton1), for: .touchUpInside)
        workItem2Button.addTarget(nil, action: #selector(actionButton2), for: .touchUpInside)
        imageDemoButton.addTarget(self, action: #selector(actionButton3), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initWorkItem1Button()
        initWorkItem2Button()
        initImageDemoButton()
    }
    
    @objc func actionButton1() {
        let workItem = DispatchWorkItem1()
        workItem.start()
    }
    
    @objc func actionButton2() {
        let workItem = DispatchWorkItem2()
        workItem.start()
    }
    
    @objc private func actionButton3() {
        let imageDemoVC = ImageDemoViewController()
        navigationController?.pushViewController(imageDemoVC, animated: true
        )
    }
    
    private func initWorkItem1Button() {
        workItem1Button.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        workItem1Button.center = CGPoint(x: view.center.x, y: view.center.y - 50)
        workItem1Button.setTitle("start workItem 1", for: .normal)
        workItem1Button.backgroundColor = .black
        workItem1Button.layer.cornerRadius = 10
        view.addSubview(workItem1Button)
    }
    
    private func initWorkItem2Button() {
        workItem2Button.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        workItem2Button.center = CGPoint(x: view.center.x, y: view.center.y + 50)
        workItem2Button.setTitle("start workItem 2", for: .normal)
        workItem2Button.backgroundColor = .black
        workItem2Button.layer.cornerRadius = 10
        view.addSubview(workItem2Button)
    }
    
    private func initImageDemoButton() {
        imageDemoButton.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        imageDemoButton.center = CGPoint(x: view.center.x, y: view.center.y + 150)
        imageDemoButton.setTitle("show image demo screen", for: .normal)
        imageDemoButton.backgroundColor = .black
        imageDemoButton.layer.cornerRadius = 10
        view.addSubview(imageDemoButton)
    }
}
