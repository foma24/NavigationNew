import UIKit

class InfoViewController: UIViewController {
    
    var alertButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        alertButtonConfig() 
    }
    
    //MARK: - alert button config
    func alertButtonConfig() {
        alertButton = UIButton(frame: CGRect(x: view.frame.width/2-100, y: view.frame.height/2-25, width: 200, height: 50))
        alertButton.layer.cornerRadius = 12
        alertButton.backgroundColor = .red
        alertButton.setTitle("Alert", for: .normal)
        
        alertButton.addTarget(self, action: #selector(alertButtonTapped), for: .touchUpInside)
        
        view.addSubview(alertButton)
    }
    
    //MARK: - alertButtonTapped
    @objc func alertButtonTapped() {
        let alert = UIAlertController(title: "AlertTitle", message: "AlertMessage", preferredStyle: .alert)
        let firstAlertAction = UIAlertAction(title: "FirstAlertAction", style: .default) { _ in
            print("First Alert Action")
        }
        let secondAlertAction = UIAlertAction(title: "SecondAlertAction", style: .default) { _ in
            print("Second Alert Action")
        }
        alert.addAction(firstAlertAction)
        alert.addAction(secondAlertAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
