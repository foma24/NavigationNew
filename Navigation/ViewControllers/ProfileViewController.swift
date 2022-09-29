import UIKit
import StorageService

class ProfileViewController: UIViewController {

    var login: String?

    static var tableView: UITableView = {
        let postTableView = UITableView(frame: .zero, style: .grouped)
        postTableView.toAutoLayout()
        postTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifire)
        postTableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifire)
        postTableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifire)
        postTableView.separatorInset = .zero
        return postTableView
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        #if DEBUG
        view.backgroundColor = .lightGray
        #else
        view.backgroundColor = .white
        #endif

        setTableView()
        setupConstraints()

    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - setup table view
    func setTableView() {
        view.addSubview(ProfileViewController.tableView)
        ProfileViewController.tableView.dataSource = self
        ProfileViewController.tableView.delegate = self
        ProfileViewController.tableView.refreshControl = UIRefreshControl()
        ProfileViewController.tableView.refreshControl?.addTarget(self, action: #selector(updatePostArray), for: .valueChanged)
    }
    
    //MARK: - Update data
    @objc func updatePostArray() {
        postArray.append(post1)
        ProfileViewController.tableView.reloadData()
        ProfileViewController.tableView.refreshControl?.endRefreshing()
    }
    
    //MARK: - Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            ProfileViewController.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ProfileViewController.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ProfileViewController.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            ProfileViewController.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    //MARK: - Arrow Button Action
    @objc private func arrowButtonAction() {
        let photoVC = PhotoViewController()
        self.navigationController?.pushViewController(photoVC, animated: true)
    }
}

//MARK: - ProfileViewController extension
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return postArray.count
        } else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = ProfileViewController.tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifire, for: indexPath) as! PostTableViewCell

            cell.configCell(author: postArray[indexPath.row].title,
                               image: postArray[indexPath.row].image,
                               description: postArray[indexPath.row].description,
                               likes: postArray[indexPath.row].likes,
                               views: postArray[indexPath.row].views)
            return cell
        } else {
            let cell = ProfileViewController.tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifire, for: indexPath) as! PhotoTableViewCell
            let gesture = UITapGestureRecognizer(target: self, action: #selector(arrowButtonAction))
            PhotoTableViewCell.arrowButton.addGestureRecognizer(gesture)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let photoVC = PhotoViewController()
            navigationController?.pushViewController(photoVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifire) as! ProfileHeaderView
            
            return headerView
            
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        } else {
            return 0
        }
    }
}
