import Foundation
import UIKit

protocol MainCoordinatorProtocol {

    func launchApp() -> UIViewController
}

final class MainCoordinator: MainCoordinatorProtocol {

    let feedCoordinator = FeedCoordinator()
    let postCoordinator = PostCoordinator()
    let logInCoordinator = LoginCoordinator()
    let profileCoordinator = ProfileCoordinator()

    func launchApp() -> UIViewController {
        return MainTabBarViewController()
    }
}
