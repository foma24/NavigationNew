import UIKit
import iOSIntPackage

class PhotoViewController: UIViewController {
    
    let facade = ImagePublisherFacade()
    
    private lazy var photosCollection: UICollectionView = {
        let photoCollectionLayout = UICollectionViewFlowLayout()
        photoCollectionLayout.scrollDirection = .vertical
        let photosCollection = UICollectionView(frame: .zero, collectionViewLayout: photoCollectionLayout)
        photosCollection.toAutoLayout()
        photosCollection.backgroundColor = Palette.whiteAndBlack
        photosCollection.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifire)
        
        return photosCollection
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosCollection.dataSource = self
        photosCollection.delegate = self
        view.addSubview(photosCollection)
        
        setupConstraints()
        
        navigationController?.navigationBar.isHidden = false
        self.title = NSLocalizedString("photo.gallery" , comment: "")
        
        facade.subscribe(self)
        //facade.addImagesWithTimer(time: 0.3, repeat: photosArray.count)
        
        DispatchQueue.main.async {
            self.facade.addImagesWithTimer(time: 0.3, repeat: photosArray.count)
            DispatchQueue.global().async {
                self.qosTest()
            }
        }
    }
    
    //MARK: - deinit
    deinit {
        facade.rechargeImageLibrary()
        facade.removeSubscription(for: self)
    }
    
    //MARK: - evaluateDuration
    private func evaluateDuration(filter: ColorFilter, qos: QualityOfService) {
        var qosTitle: String
        switch qos {
        case .userInteractive:
            qosTitle = "userInteractive"
        case .userInitiated:
            qosTitle = "userInitiated"
        case .utility:
            qosTitle = "utility"
        case .background:
            qosTitle = "background"
        case .default:
            qosTitle = "default"
        @unknown default:
            qosTitle = "unknown default"
        }
        
        let imageProcessor = ImageProcessor()
        
        let start = DispatchTime.now() // <<<<<<<<<< Start time
        print("START")
        
        imageProcessor.processImagesOnThread(sourceImages: photosArray, filter: filter, qos: qos) { [weak self] images in
            
            let newCollection = images.compactMap { $0 }
            photosArray = newCollection.map { UIImage(cgImage: $0) }
            
            DispatchQueue.main.async {
                self?.photosCollection.reloadData()
            }
            
            let end = DispatchTime.now()   // <<<<<<<<<<   end time
            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
            let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests
            print("Evaluated duration: \(timeInterval) seconds using \(qosTitle) qos for \(filter)")
        }
        
    }
    
    //MARK: - qosTest
    private func qosTest() {
        
        // 0.000157208 seconds, 4 новых потока
        evaluateDuration(filter: .colorInvert, qos: .userInteractive)
        
        // 0.000174175 seconds, 4 новых потока
        //evaluateDuration(filter: .chrome, qos: .userInitiated)

        // 0.000131183 seconds, 4 новых потока
        //evaluateDuration(filter: .motionBlur(radius: 3), qos: .default)
        
        // 0.000161359 seconds, 4 новых потока
        //evaluateDuration(filter: .crystallize(radius: 4), qos: .utility)
        
        // 0.000168718 seconds, 5 новых потоков
        //evaluateDuration(filter: .bloom(intensity: 0.2), qos: .background)
    }
    
    //MARK: - setupConstraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photosCollection.topAnchor.constraint(equalTo: view.topAnchor),
            photosCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photosCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - Collection view
extension PhotoViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollection.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifire, for: indexPath) as! PhotoCollectionViewCell
        cell.configureCell(image: photosArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 3
        let paddindWidth = 8 * (itemsPerRow + 1)
        let accessibleWidth = collectionView.frame.width - paddindWidth
        let widthPerItem = accessibleWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

//MARK: - ImageLibrarySubscriber ext
extension PhotoViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        photosArray = []
        for i in images {
            photosArray.append(i)
        }
        photosCollection.reloadData()
    }
}
