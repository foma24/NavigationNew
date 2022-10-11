import Foundation

class PostViewModel {
    private let coordinator: PostCoordinator

    init(coordinator: PostCoordinator) {
        self.coordinator = coordinator
    }

    func presentInfo() {
        coordinator.presentInfo()
    }
}
