import UIKit

class PostViewController: UIViewController {
    
    private let viewModel: PostViewModel
    
    var postTitle: String?
    
    init(viewModel: PostViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.title = postTitle
        
        let infoBarItem: UIBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(infoTapped))
        
        navigationItem.rightBarButtonItem = infoBarItem
    }
    
    @objc func infoTapped() {
        //        let infoVC = InfoViewController()
        //        navigationController?.present(infoVC, animated: true)
        viewModel.presentInfo()
    }
}
