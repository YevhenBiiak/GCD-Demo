import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: - DispatchGroup

/// Группа задач, которые вы отслеживаете как единое целое.
/// Группы позволяют объединять набор задач и синхронизировать поведение в группе. Вы присоединяете несколько рабочих элементов к группе и планируете их асинхронное выполнение в одной или разных очередях. Когда все рабочие элементы завершают выполнение, группа выполняет свой обработчик завершения. Вы также можете синхронно дождаться завершения выполнения всех задач в группе.
/// enter() - ручное вход. добавление в группу
/// leave() - сигнал о выходи из группы


class DispatchGroupTest {
    private let serialQueue = DispatchQueue(label: "mySerial")
    private let concurrentQueue = DispatchQueue(label: "myConcurrent", attributes: [.concurrent])
    private let serialGroup = DispatchGroup()
    private let concurrentGroup = DispatchGroup()
    
    func makeWorkUsingSerialQueue() {
        serialQueue.async(group: serialGroup) {
            sleep(1)
            print("Serial work 1")
        }
        serialQueue.async(group: serialGroup) {
            sleep(1)
            print("Serial work 2")
        }
        serialGroup.notify(queue: DispatchQueue.main) {
            print("Serial group work is finished")
        }
    }
    func makeWorkUsingConcurrentQueue() {
        concurrentQueue.async(group: concurrentGroup) {
            sleep(1)
            print("Concurrent work 1")
        }
        concurrentQueue.async(group: concurrentGroup) {
            sleep(1)
            print("Concurrent work 2")
        }
        concurrentGroup.notify(queue: DispatchQueue.main) {
            print("Concurrent group work is finished")
        }
    }
}

let groupTest = DispatchGroupTest()
//groupTest.makeWorkUsingSerialQueue()
//groupTest.makeWorkUsingConcurrentQueue()

class DispatchGroupTest2 {
    private let queue = DispatchQueue(label: "myConcurrent", attributes: [.concurrent])
    private let group = DispatchGroup()
    
    func makeWor() {
        group.enter()
        queue.async {
            sleep(2)
            print("1")
            self.group.leave()
        }
        
        group.enter()
        queue.async {
            sleep(2)
            print("2")
            self.group.leave()
        }
        
        // wait for group work to complete
        group.wait()
        print("group work is finished")
    }
}

let groupTest2 = DispatchGroupTest2()
//groupTest2.makeWor()

// real example

class  EightImageView: UIView {
    var imageViews = [UIImageView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageViews.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
        imageViews.append(UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100)))
        imageViews.append(UIImageView(frame: CGRect(x: 100, y: 0, width: 100, height: 100)))
        imageViews.append(UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
        
        for imageView in imageViews {
            imageView.contentMode = .scaleAspectFit
            self.addSubview(imageView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let imageURLs = [
    "http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg",
    "https://bestkora.com/IosDeveloper/wp-content/uploads/2022/01/Screenshot-2022-01-16-at-17.07.13.png",
    "https://bestkora.com/IosDeveloper/wp-content/uploads/2014/07/cropped-Imperia.jpg"]

let view = EightImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.backgroundColor = .yellow
PlaygroundPage.current.liveView = view

var images = [UIImage]()
// service func

func asyncLoadImageGroup(
    stringURLs: [String]
) {
    let group = DispatchGroup()
    for stringURL in stringURLs {
        group.enter()
        let url = URL(string: stringURL)!
        asyncLoadImage(
            imageURL: url,
            runQueue: .global(),
            completionQueue: .main
        ) { image, error in
            guard let image else { return }
            images.append(image)
            group.leave()
        }
    }
    
    group.notify(queue: .main) {
        for (i, _) in stringURLs.enumerated() {
            view.imageViews[i].image = images[i]
        }
    }
}

func asyncLoadImage(
    imageURL: URL,
    runQueue: DispatchQueue,
    completionQueue: DispatchQueue,
    completion: @escaping (UIImage?, Error?) -> ()
) {
    runQueue.async {
        do {
            let data = try Data(contentsOf: imageURL)
            completionQueue.async {
               completion(UIImage(data: data), nil)
            }
        } catch {
            completionQueue.async {
                completion(nil, error)
            }
        }
    }
}

// runing

asyncLoadImageGroup(stringURLs: imageURLs)
