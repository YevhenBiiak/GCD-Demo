//
//  ImageDemoViewController.swift
//  GCD Demo
//
//  Created by Евгений Бияк on 18.10.2022.
//

import UIKit

class ImageDemoViewController: UIViewController {
    
    private let imageView = UIImageView()
    private let demo1Button = UIButton()
    private let demo2Button = UIButton()
    private let demo3Button = UIButton()
    
    private let imgURL = URL(string: "https://wallpapershome.ru/images/wallpapers/raduga-2160x3840-4k-5k-8k-lepestki-stranici-cvetnie-fon-261.jpg")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Image ViewController"
        view.backgroundColor = .secondarySystemBackground
        
        demo1Button.addTarget(nil, action: #selector(actionButton1), for: .touchUpInside)
        demo2Button.addTarget(nil, action: #selector(actionButton2), for: .touchUpInside)
        demo3Button.addTarget(nil, action: #selector(actionButton3), for: .touchUpInside)
        
        initImageView()
        initDemo1Button()
        initDemo2Button()
        initDemo3Button()
    }
    
    @objc func actionButton1() {
        imageView.image = nil
        fetchImage(url: imgURL)
    }
    
    @objc func actionButton2() {
        imageView.image = nil
        fetchImageWithWorkItem(url: imgURL)
    }
    
    @objc func actionButton3() {
        imageView.image = nil
        fetchImageWithURLSession(url: imgURL)
    }
    
    private func initImageView() {
        imageView.frame = CGRect(x: 0, y: 200, width: 300, height: 300)
        imageView.center.x = view.center.x
        imageView.layer.cornerRadius = 10
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1.0
        imageView.clipsToBounds = true
        view.addSubview(imageView)
    }
    
    private func initDemo1Button() {
        demo1Button.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        demo1Button.center = CGPoint(x: view.center.x, y: view.center.y + 100)
        demo1Button.setTitle("demo 1", for: .normal)
        demo1Button.backgroundColor = .black
        demo1Button.layer.cornerRadius = 10
        view.addSubview(demo1Button)
    }
    
    private func initDemo2Button() {
        demo2Button.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        demo2Button.center = CGPoint(x: view.center.x, y: view.center.y + 180)
        demo2Button.setTitle("demo 2", for: .normal)
        demo2Button.backgroundColor = .black
        demo2Button.layer.cornerRadius = 10
        view.addSubview(demo2Button)
    }
    
    private func initDemo3Button() {
        demo3Button.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        demo3Button.center = CGPoint(x: view.center.x, y: view.center.y + 260)
        demo3Button.setTitle("demo 3", for: .normal)
        demo3Button.backgroundColor = .black
        demo3Button.layer.cornerRadius = 10
        view.addSubview(demo3Button)
    }
    
    // classic method
    func fetchImage(url: URL?) {
        let queue = DispatchQueue.global(qos: .utility)
        
        queue.async {
            if let url, let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    // dispatch work item method
    private func fetchImageWithWorkItem(url: URL?) {
        var data: Data?
        let queue = DispatchQueue.global(qos: .utility)
        
        let workItem = DispatchWorkItem(qos: .userInteractive) {
            if let url {
                data = try? Data(contentsOf: url)
            }
        }
        
        queue.async(execute: workItem)
        
        workItem.notify(queue: .main) {
            if let data {
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    
    // URLSession
    private func fetchImageWithURLSession(url: URL?) {
        URLSession.shared.dataTask(with: url!) { data, response, error in
            DispatchQueue.main.async {
                if let data {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
