import Foundation
import UIKit

final class ProfileCoordinator {
    var navigationController: UINavigationController?
    
    func showPhotoGallery() {
        createVC()
    }
}

extension ProfileCoordinator: ControllerFactoryProtocol {
    func createVC() {
        let controller = PhotoViewController()
        controller.navigationController?.isNavigationBarHidden = false
        self.navigationController!.pushViewController(controller, animated: true)
    }
}
