import Foundation

class ProfileViewModel {

    private let coordinator: ProfileCoordinator

    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
    }

    func showGallery() {
        coordinator.showPhotoGallery()
    }
}
