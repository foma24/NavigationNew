import Foundation
import CoreData
import StorageService

struct FavoritePost {
    var title: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
}

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    static var favoritePostsArray: [FavoritePost] = []
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError()
            }
        }
        return container
    }()
    
    private lazy var context = persistentContainer.newBackgroundContext()
    
    //MARK: - addPostInFavourite
    func addPostInFavorite(postIndex: Int) {
        context.perform { [weak self] in
            guard let self = self else { return }
            if let newFavoritePost = NSEntityDescription.insertNewObject(forEntityName: "FavouritePosts", into: self.context) as? FavouritePosts {
                newFavoritePost.post_id = UUID()
                newFavoritePost.post_title = postArray[postIndex].title
                newFavoritePost.post_image = postArray[postIndex].image
                newFavoritePost.post_description = postArray[postIndex].description
                newFavoritePost.post_likes = Int16(postArray[postIndex].likes)
                newFavoritePost.post_views = Int16(postArray[postIndex].views)
            } else {
                fatalError()
            }
            
            do {
                try self.context.save()
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: Notification.Name("updateFavoritePosts"), object: nil)
                }
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: - deletePostFromFavourite
    func deletePostFromFavorite(postIndex: Int) {
        let fetchRequest = FavouritePosts.fetchRequest()
        do {
            let favoritePosts = try context.fetch(fetchRequest)
            for i in favoritePosts.indices {
                
                if i == postIndex {
                    context.delete(favoritePosts[i])
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name("updateFavoritePosts"), object: nil)
                    }
                }
            }
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - getPostFromFavourite
    func getPostFromFavorite() {
        CoreDataManager.favoritePostsArray = []
        let fetchRequest = FavouritePosts.fetchRequest()
        do {
            let favouritePosts = try context.fetch(fetchRequest)
            for i in favouritePosts {
                guard let post_title = i.post_title else { return }
                guard let post_description = i.post_description else { return }
                guard let post_image = i.post_image else { return }
                
                let tempPost = FavoritePost(title: post_title, description: post_description, image: post_image, likes: Int(i.post_likes), views: Int(i.post_views))
                
                CoreDataManager.favoritePostsArray.append(tempPost)
            }
        } catch {
            print(error)
        }
    }
    
    //MARK: - getAuthorFilterPostsFromFavorite
    func getAuthorFilterPostsFromFavorite(author: String) {

            CoreDataManager.favoritePostsArray = []

            let predicate = NSPredicate(format: "%K == %@", #keyPath(FavouritePosts.post_title), "\(author)" )

            do {

                let fetchRequest = FavouritePosts.fetchRequest()
                fetchRequest.predicate = predicate

                let favouritePosts = try context.fetch(fetchRequest)

                for i in favouritePosts {

                    guard let post_title = i.post_title else { return }
                    guard let post_description = i.post_description else { return }
                    guard let post_image = i.post_image else { return }

                    let tempPost = FavoritePost(title: post_title, description: post_description, image: post_image, likes: Int(i.post_likes), views: Int(i.post_views))

                    CoreDataManager.favoritePostsArray.append(tempPost)
                }
            } catch {
                print(error)
            }
        }
}
