//
//  ImageViewController.swift
//  GCD Demo
//
//  Created by Евгений Бияк on 14.10.2022.
//

import UIKit

class ImageViewController: UIViewController {
    
    let imageView = UIImageView()
    
    let imgURL = URL(string: "https://wallpapershome.ru/images/wallpapers/raduga-2160x3840-4k-5k-8k-lepestki-stranici-cvetnie-fon-261.jpg")!
    var isAsyncLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Image ViewController"
        view.backgroundColor = .secondarySystemBackground
        
        isAsyncLoad ? loadImageAsync() : loadImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initImageView()
    }
    
    @objc func action() {
        navigationController?.popViewController(animated: true)
    }
    
    private func initImageView() {
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        imageView.backgroundColor = .yellow
        imageView.center = view.center
        imageView.layer.cornerRadius = 10
        view.addSubview(imageView)
    }
    
    private func loadImage() {
        if let data = try? Data(contentsOf: imgURL) {
            imageView.image = UIImage(data: data)
        }
    }
    
    private func loadImageAsync() {
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            if let data = try? Data(contentsOf: self.imgURL) {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
    }
}
