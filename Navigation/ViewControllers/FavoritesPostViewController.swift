import UIKit

class FavoritesPostViewController: UIViewController {
    var titleSearch: String = ""
    private lazy var favoritePostsTableView: UITableView = {
        let favouritePostsTableView = UITableView(frame: .zero, style: .grouped)
        favouritePostsTableView.toAutoLayout()
        favouritePostsTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifire)
        favouritePostsTableView.separatorInset = .zero
        return favouritePostsTableView
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        CoreDataManager.shared.getPostFromFavorite()
        view.addSubviews(favoritePostsTableView)
        setupConstraints()
        favoritePostsTableView.delegate = self
        favoritePostsTableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateFavoritePosts), name: NSNotification.Name.init(rawValue: "updateFavoritePosts"), object: nil)
        
        let leftBarButton = UIBarButtonItem(barButtonSystemItem:.search, target: self, action: #selector(titleFilter))
        navigationItem.leftBarButtonItem = leftBarButton

        let rightBarButton = UIBarButtonItem(barButtonSystemItem:.trash, target: self, action: #selector(updateFavoritePosts))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    //MARK: - Filter AC
    @objc func titleFilter() {
        let alertVC = UIAlertController(title: "Filter", message: "", preferredStyle: .alert)
        alertVC.addTextField { [self] textField in
            textField.placeholder = "by Title"
            textField.addTarget(self, action: #selector(titleFilterTextField(_:)), for: .editingChanged)
        }

        let alertAction = UIAlertAction(title: "Set", style: .default) { _ in
            CoreDataManager.shared.getAuthorFilterPostsFromFavorite(author: self.titleSearch)
            self.favoritePostsTableView.reloadData()
            self.favoritePostsTableView.refreshControl?.endRefreshing()
        }

        alertVC.addAction(alertAction)

        self.present(alertVC, animated: true)
    }

    @objc func titleFilterTextField(_ textField: UITextField) {
        guard let titleTextField = textField.text else { return }
        titleSearch = titleTextField
    }
    
    //MARK: - updateFavoritePosts
    @objc func updateFavoritePosts() {
        CoreDataManager.shared.getPostFromFavorite()
        self.favoritePostsTableView.reloadData()
        self.favoritePostsTableView.refreshControl?.endRefreshing()
    }
    
    //MARK: - setupConstraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            favoritePostsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoritePostsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            favoritePostsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            favoritePostsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

//MARK: - TableView
extension FavoritesPostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.favoritePostsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritePostsTableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifire, for: indexPath) as! PostTableViewCell
        cell.configCell(author: CoreDataManager.favoritePostsArray[indexPath.row].title,
                        image: CoreDataManager.favoritePostsArray[indexPath.row].image,
                        description: CoreDataManager.favoritePostsArray[indexPath.row].description,
                        likes: CoreDataManager.favoritePostsArray[indexPath.row].likes,
                        views: CoreDataManager.favoritePostsArray[indexPath.row].views)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete", handler: { (_, _, completionHandler) in
            completionHandler(true)
            CoreDataManager.shared.deletePostFromFavorite(postIndex: indexPath.row)
        })
        return UISwipeActionsConfiguration(actions: [action])
    }
}
