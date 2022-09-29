import UIKit
import iOSIntPackage

class PhotoViewController: UIViewController {
    
    let facade = ImagePublisherFacade()
    
    private lazy var photosCollection: UICollectionView = {
        let photoCollectionLayout = UICollectionViewFlowLayout()
        photoCollectionLayout.scrollDirection = .vertical
        let photosCollection = UICollectionView(frame: .zero, collectionViewLayout: photoCollectionLayout)
        photosCollection.toAutoLayout()
        photosCollection.backgroundColor = .white
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
        self.title = "Photo Gallery"
        
        facade.subscribe(self)
        facade.addImagesWithTimer(time: 0.3, repeat: photosArray.count)
    }
    
    deinit {
        facade.rechargeImageLibrary()
        facade.removeSubscription(for: self)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photosCollection.topAnchor.constraint(equalTo: view.topAnchor),
            photosCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photosCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// - MARK: Collection view
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

extension PhotoViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        photosArray = []
        for i in images {
            photosArray.append(i)
        }
        photosCollection.reloadData()
    }
}
