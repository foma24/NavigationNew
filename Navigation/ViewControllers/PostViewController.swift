import UIKit

class PostViewController: UIViewController {
    
    private let postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.toAutoLayout()
        postImage.backgroundColor = .systemGray
        postImage.contentMode = .scaleAspectFill

        return postImage
    }()

    private let likesCountLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.text = "Likes: 0"

        return label
    }()

    private let viewsCountLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.text = "Views: 0"

        return label
    }()

    private var timer: Timer?
    private var likesCount: Int = 0
    private var viewsCount: Int = 0
    var postTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.title = postTitle
        
        let infoBarItem: UIBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(infoTapped))
        navigationItem.rightBarButtonItem = infoBarItem
        
        view.addSubviews(postImage, likesCountLabel, viewsCountLabel)
        setupSubviewsLayout()
        
        DispatchQueue.global().async {
            self.startTimer()
            RunLoop.current.add(self.timer!, forMode: .common)
            RunLoop.current.run()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopTimer()
    }
    
    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            postImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            postImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            postImage.bottomAnchor.constraint(equalTo: view.centerYAnchor),

            likesCountLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 8),
            likesCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            viewsCountLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 8),
            viewsCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])

    }

    private func startTimer() {
        print(#function)
        guard timer == nil else {return}
        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        timer?.tolerance = 0.2
    }

    private func stopTimer() {
        print(#function)
        guard timer != nil else {return}
        timer?.invalidate()
        timer = nil
    }
    
    @objc func timerAction() {
        guard let randomLikes = Array(5...10).randomElement() else { return }
        guard let randomViews = Array(10...15).randomElement() else { return }
        likesCount += randomLikes
        viewsCount += randomViews

        DispatchQueue.main.async {
            self.likesCountLabel.text = "Likes: \(self.likesCount)"
            self.viewsCountLabel.text = "Views: \(self.viewsCount)"
        }
    }
    
    @objc func infoTapped() {
        let infoVC = InfoViewController()
        navigationController?.present(infoVC, animated: true)
    }
}
