import Foundation
import UIKit

final class LoginCoordinator {
    
    var navigationController: UINavigationController?
    
    private var loginUsername: String?
    private var currentuser: UserService?

    func showProfile(usernameText: String?) {
        self.loginUsername = usernameText!
        createVC()
    }
}

extension LoginCoordinator: ControllerFactoryProtocol {
    func createVC() {
        let mainCoordinator = MainCoordinator()
        let coordinator = mainCoordinator.profileCoordinator
        let viewModel = ProfileViewModel(coordinator: coordinator)
        let controller = ProfileViewController(viewModel: viewModel)
        coordinator.navigationController = self.navigationController!
        self.navigationController!.pushViewController(controller, animated: true)
    }
}
