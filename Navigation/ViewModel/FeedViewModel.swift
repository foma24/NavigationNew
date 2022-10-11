import Foundation
import StorageService

protocol FeedViewModelDelegate {

}

class FeedViewModel {

    private let coordinator: FeedCoordinator

    init(coordinator: FeedCoordinator) {
        self.coordinator = coordinator
    }

    func post1DidTap() {
        coordinator.pushPost(post: post1)
    }

    func post2DidTap() {
        coordinator.pushPost(post: post2)
    }

//    func keywordCheck(text: String) -> Bool {
//        if FeedModel.check(word: text) {
//            return true
//        } else {
//            return false
//        }
//    }

}
