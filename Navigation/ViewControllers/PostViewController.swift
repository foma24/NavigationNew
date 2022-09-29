import UIKit

class PostViewController: UIViewController {
    
    var postTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.title = postTitle
        
        let infoBarItem: UIBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(infoTapped))
        
        navigationItem.rightBarButtonItem = infoBarItem
    }
    
    @objc func infoTapped() {
        let infoVC = InfoViewController()
        navigationController?.present(infoVC, animated: true)
    }
}
