import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
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
        
        //MARK: Tab Bar
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.viewControllers = [feedNavigationController, loginNavigationController]
        tabBarController.selectedIndex = 0
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}

