import Foundation
import UIKit

class LogInViewModel {

    private let coordinator: LoginCoordinator

    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
    }

    func showProfileVC(usernameText: String?) {
        coordinator.showProfile(usernameText: usernameText)
    }
}
