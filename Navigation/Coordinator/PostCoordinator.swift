import Foundation
import UIKit

final class PostCoordinator {
    var navigatioController: UINavigationController?
    
    func presentInfo() {
        let infoVC = InfoViewController()
        navigatioController?.present(infoVC, animated: true, completion: nil)
    }
}
