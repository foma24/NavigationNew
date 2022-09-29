import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    static let identifire = "PhotosTableViewCell"

    private lazy var photosLabel: UILabel = {
        let photosLabel = UILabel()
        photosLabel.text = "My Photos"
        photosLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        photosLabel.textColor = .black
        photosLabel.toAutoLayout()
        
        return photosLabel
    }()

    static var arrowButton: UIButton = {
        let arrowButton = UIButton()
        arrowButton.setImage(UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        arrowButton.setImage(UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .highlighted)
        arrowButton.toAutoLayout()
        
        return arrowButton
    }()
    
    private lazy var previewStackView: UIStackView = {
        let previewStackView = UIStackView()
        previewStackView.toAutoLayout()
        previewStackView.axis = .horizontal
        previewStackView.distribution = .fillEqually
        previewStackView.alignment = .center
        previewStackView.spacing = 8
        
        return previewStackView
    }()
    
    private lazy var previewImage1:UIImageView = {
        let image = UIImage(named: "photo1")
        let imageView = UIImageView()
        imageView.image = image
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.toAutoLayout()
        
        return imageView
    }()
    
    private lazy var previewImage2:UIImageView = {
        let image = UIImage(named: "photo2")
        let imageView = UIImageView()
        imageView.image = image
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.toAutoLayout()
        
        return imageView
    }()
    
    private lazy var previewImage3:UIImageView = {
        let image = UIImage(named: "photo3")
        let imageView = UIImageView()
        imageView.image = image
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.toAutoLayout()
        
        return imageView
    }()
    
    private lazy var previewImage4:UIImageView = {
        let image = UIImage(named: "photo4")
        let imageView = UIImageView()
        imageView.image = image
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.toAutoLayout()
        
        return imageView
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.addSubviews(photosLabel, PhotoTableViewCell.arrowButton, previewStackView)
        previewStackView.addArrangedSubviews(previewImage1, previewImage2, previewImage3, previewImage4)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: - Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            PhotoTableViewCell.arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            PhotoTableViewCell.arrowButton.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            PhotoTableViewCell.arrowButton.heightAnchor.constraint(equalToConstant: 40),
            PhotoTableViewCell.arrowButton.widthAnchor.constraint(equalToConstant: 40),
            
            previewStackView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            previewStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            previewStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            previewStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            previewImage1.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 16) / 4),
            previewImage1.heightAnchor.constraint(equalTo: previewImage1.widthAnchor),
            
            previewImage2.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 16) / 4),
            previewImage2.heightAnchor.constraint(equalTo: previewImage2.widthAnchor),
            
            previewImage3.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 16) / 4),
            previewImage3.heightAnchor.constraint(equalTo: previewImage2.widthAnchor),
            
            previewImage4.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 16) / 4),
            previewImage4.heightAnchor.constraint(equalTo: previewImage2.widthAnchor),
            
        ])
    }
}
