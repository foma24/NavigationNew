import Foundation
import UIKit
import StorageService

final class FeedCoordinator {
    
    var navigationController: UINavigationController?
    
    private var post: Post?
    
    func pushPost(post: Post) {
        self.post = post
        createVC()
        
        func popPost(navController: UINavigationController?) {
            navController?.popViewController(animated: true)
        }
    }
}
    
    extension FeedCoordinator: ControllerFactoryProtocol {
        func createVC() {
            let mainCoordinator = MainCoordinator()
            let coordinator = mainCoordinator.postCoordinator
            let viewModel = PostViewModel(coordinator: coordinator)
            let controller = PostViewController(viewModel: viewModel)
            coordinator.navigatioController = self.navigationController!
            controller.title = self.post!.title
            self.navigationController!.pushViewController(controller, animated: true)
        }
    }

