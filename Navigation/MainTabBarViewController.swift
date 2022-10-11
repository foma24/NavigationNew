import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {

    private let feedVC = ControllerFactory(flow: .feed)
    private let loginVC = ControllerFactory(flow: .login)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupControllers()
    }

    private func setupControllers() {

        viewControllers = [
            feedVC.navigationController,
            loginVC.navigationController
        ]
        tabBar.backgroundColor = .white
    }

}
