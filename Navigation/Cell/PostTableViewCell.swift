import UIKit
import iOSIntPackage

class PostTableViewCell: UITableViewCell {
    
    static let identifire = "PostTableViewCell"
    
    private lazy var postTitle: UILabel = {
        let postTitle = UILabel()
        postTitle.toAutoLayout()
        postTitle.numberOfLines = 2
        postTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        return postTitle
    }()
    
    private lazy var postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.toAutoLayout()
        postImage.backgroundColor = .black
        postImage.contentMode = .scaleAspectFit
        
        return postImage
    }()
    
    private lazy var postDescription: UILabel = {
        let postDescription = UILabel()
        postDescription.toAutoLayout()
        postDescription.font = UIFont.systemFont(ofSize: 14)
        postDescription.textColor = .systemGray
        postDescription.numberOfLines = 0
        
        return postDescription
    }()
    
    private lazy var postLikes: UILabel = {
        let postLikes = UILabel()
        postLikes.toAutoLayout()
        postLikes.font = UIFont.systemFont(ofSize: 16)
        postLikes.textColor = .black
        
        return postLikes
    }()
    
    private lazy var postViews: UILabel = {
        let postViews = UILabel()
        postViews.toAutoLayout()
        postLikes.font = UIFont.systemFont(ofSize: 16)
        postLikes.textColor = .black
        
        return postViews
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(postTitle, postImage, postDescription, postLikes, postViews)
        self.selectionStyle = .none
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: - Cell config
    public func configCell(author: String, image: String, description: String, likes: Int, views: Int) {
        self.postTitle.text = author
        self.postImage.image = UIImage(named: image)
        
        // применяем фильтр к изображению
        let randomInt = Int.random(in: 1...8)
        let filter: ColorFilter?
        
        switch randomInt {
            case 1: filter = .posterize
            case 2: filter = .colorInvert
            case 3: filter = .transfer
            case 4: filter = .noir
            case 5: filter = .tonal
            case 6: filter = .process
            case 7: filter = .chrome
            case 8: filter = .fade
            default: filter = nil
        }
        
        let processor = ImageProcessor()
        guard let filter = filter else { return }
        guard let image = postImage.image else { return }
        
        processor.processImage(sourceImage: image, filter: filter) { filteredImage in
            postImage.image = filteredImage
        }
        
        self.postDescription.text = description
        self.postLikes.text = "Likes: \(likes)"
        self.postViews.text = "Views: \(views)"
    }
    
    //MARK: - Setup constraints
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            postTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            postTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor),
            postImage.topAnchor.constraint(equalTo: postTitle.bottomAnchor, constant: 16),
            
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postLikes.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            postLikes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postLikes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            postViews.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            postViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
}
