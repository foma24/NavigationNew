import Foundation
import UIKit

protocol ControllerFactoryProtocol: AnyObject {
    func createVC()
}

final class ControllerFactory {

    enum Flow {
        case feed
        case login
    }

    let mainCoordinator = MainCoordinator()
    let navigationController: UINavigationController = UINavigationController()
    let flow: Flow

    init(flow: Flow) {
        self.flow = flow
        createModule()
    }

    private func createModule() {
        switch flow {
        case .feed:
            let coordinator = mainCoordinator.feedCoordinator
            let viewModel = FeedViewModel(coordinator: coordinator)
            let controller = FeedViewController(viewModel: viewModel)
            coordinator.navigationController = navigationController
            navigationController.tabBarItem.title = "Feed"
            navigationController.tabBarItem.image = UIImage(systemName: "doc.plaintext.fill")
            navigationController.setViewControllers([controller], animated: true)

        case .login:
            let coordinator = mainCoordinator.logInCoordinator
            let viewModel = LogInViewModel(coordinator: coordinator)
            let controller = LogInViewController(viewModel: viewModel)
            coordinator.navigationController = navigationController
            navigationController.tabBarItem.title = "Profile"
            navigationController.tabBarItem.image = UIImage(systemName: "folder.fill")

            let loginFactory = LoginFactory()
            controller.delegate = loginFactory.createLoginInspector()
            navigationController.setViewControllers([controller], animated: true)
        }
    }


}
