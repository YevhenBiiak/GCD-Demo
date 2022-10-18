//
//  MainViewController.swift
//  GCD Demo
//
//  Created by Евгений Бияк on 14.10.2022.
//

import UIKit

class MainViewController: UIViewController {

    let syncLoadButton = UIButton()
    let asyncLoadButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        
        syncLoadButton.addTarget(nil, action: #selector(actionButton1), for: .touchUpInside)
        asyncLoadButton.addTarget(nil, action: #selector(actionButton2), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initSyncLoadButton()
        initAsyncLoadButton()
    }
    
    @objc func actionButton1() {
        let imageVC = ImageViewController()
        imageVC.isAsyncLoad = false
        navigationController?.pushViewController(imageVC, animated: true)
    }
    
    @objc func actionButton2() {
        let imageVC = ImageViewController()
        imageVC.isAsyncLoad = true
        navigationController?.pushViewController(imageVC, animated: true)
    }
    
    private func initSyncLoadButton() {
        syncLoadButton.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        syncLoadButton.center = CGPoint(x: view.center.x, y: view.center.y - 50)
        syncLoadButton.setTitle("load image sync", for: .normal)
        syncLoadButton.backgroundColor = .black
        syncLoadButton.layer.cornerRadius = 10
        view.addSubview(syncLoadButton)
    }
    
    private func initAsyncLoadButton() {
        asyncLoadButton.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        asyncLoadButton.center = CGPoint(x: view.center.x, y: view.center.y + 50)
        asyncLoadButton.setTitle("load image async", for: .normal)
        asyncLoadButton.backgroundColor = .black
        asyncLoadButton.layer.cornerRadius = 10
        view.addSubview(asyncLoadButton)
    }
}

