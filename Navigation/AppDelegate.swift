import UIKit
import FirebaseAuth
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        //MARK: Firebase
        FirebaseApp.configure()
        
        //MARK: Network request
        let appConfiguration: AppConfiguration = AppConfiguration.people
        NetworkService.request(for: appConfiguration)
        
        //MARK: feedVC
        let feedBarItem = UITabBarItem()
        feedBarItem.title = "Feed"
        feedBarItem.image = UIImage(systemName: "doc.plaintext")
        feedBarItem.selectedImage = UIImage(systemName: "doc.plaintext.fill")
        let feedVC = FeedViewController()
        feedVC.view.backgroundColor = .white
        feedVC.title = "Feed"
        let feedNavigationController = UINavigationController(rootViewController: feedVC)
        feedVC.tabBarItem = feedBarItem
        
        //MARK: profileVC
        let profileBarItem = UITabBarItem()
        profileBarItem.title = "Profile"
        profileBarItem.image = UIImage(systemName: "folder")
        profileBarItem.selectedImage = UIImage(systemName: "folder.fill")
        //        let profileVC = ProfileViewController()
        //        profileVC.title = "Profile"
        
        //MARK: loginVC
        let loginVC = LogInViewController()
        loginVC.view.backgroundColor = .white
        let loginNavigationController = UINavigationController(rootViewController: loginVC)
        loginVC.tabBarItem = profileBarItem
        
        let factory = LoginFactory()
        let inspector = factory.createLoginInspector()
        loginVC.delegate = inspector
        
        //MARK: favoritesVC
        let favoritesVC = FavoritesPostViewController()
        let favoritesPostNavigationController = UINavigationController(rootViewController: favoritesVC)
        let addFilterFavoritePostsButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        favoritesPostNavigationController.navigationItem.leftBarButtonItem = addFilterFavoritePostsButton
        let favoritesBarItem = UITabBarItem()
        favoritesVC.title = "Favorites"
        favoritesBarItem.title = "Favorites"
        favoritesBarItem.image = UIImage(systemName: "heart")
        favoritesBarItem.selectedImage = UIImage(systemName: "heart.fill")
        favoritesVC.tabBarItem = favoritesBarItem
        
        //MARK: Tab Bar
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.viewControllers = [feedNavigationController, loginNavigationController, favoritesPostNavigationController]
        tabBarController.selectedIndex = 0
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        do {
            try Auth.auth().signOut()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}

