import UIKit

class FavoritesPostViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        CoreDataManager.shared.getPostFromFavourite()
        view.addSubviews(favoritePostsTableView)
        setupConstraints()
        favoritePostsTableView.delegate = self
        favoritePostsTableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateFavoritePosts), name: NSNotification.Name.init(rawValue: "updateFavoritePosts"), object: nil)
    }
    
    
    @objc func updateFavoritePosts() {
        CoreDataManager.shared.getPostFromFavourite()
        self.favoritePostsTableView.reloadData()
        self.favoritePostsTableView.refreshControl?.endRefreshing()
    }
    
    private lazy var favoritePostsTableView: UITableView = {
        let favouritePostsTableView = UITableView(frame: .zero, style: .grouped)
        favouritePostsTableView.toAutoLayout()
        favouritePostsTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifire)
        favouritePostsTableView.separatorInset = .zero
        return favouritePostsTableView
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            favoritePostsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoritePostsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            favoritePostsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            favoritePostsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

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
}
