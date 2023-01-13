import UIKit

class InfoViewController: UIViewController {
    
    var residents: [Residents] = []
    
    private lazy var alertButton: UIButton = {
        let alertButton = UIButton()
        alertButton.toAutoLayout()
        alertButton.layer.cornerRadius = 10
        alertButton.clipsToBounds = true
        alertButton.backgroundColor = .red
        alertButton.setTitle(NSLocalizedString("alert", comment: "") , for: .normal)
        alertButton.setTitleColor(.white, for: .normal)
        alertButton.addTarget(self, action: #selector(alertButtonTapped), for: .touchUpInside)
        
        return alertButton
    }()
    
    private let urlLabel: UILabel = {
        let urlLabel = UILabel()
        urlLabel.toAutoLayout()
        NetworkService.request(id: 2) { title in
            DispatchQueue.main.async {
                urlLabel.text = "Title from URL: \(title)"
            }
        }
        
        return urlLabel
    }()
    
    private let planetLabel: UILabel = {
        let planetLabel = UILabel()
        planetLabel.toAutoLayout()
        NetworkService.request { planet in
            DispatchQueue.main.async {
                planetLabel.text = "Tatooine orbital period: \(planet.orbitalPeriod)"
            }
        }
        return planetLabel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.layer.cornerRadius = 10
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        setupSubviews()
        setupSubviewsLayout()
        updateTableView()
    }
    
    //MARK: - setupSubviews
    private func setupSubviews(){
        view.addSubview(alertButton)
        view.addSubview(urlLabel)
        view.addSubview(planetLabel)
        view.addSubview(tableView)
    }
    
    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            alertButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertButton.widthAnchor.constraint(equalToConstant: 200),
            alertButton.heightAnchor.constraint(equalToConstant: 50),
            
            urlLabel.topAnchor.constraint(equalTo: alertButton.bottomAnchor, constant: 16),
            urlLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            planetLabel.topAnchor.constraint(equalTo: urlLabel.bottomAnchor, constant: 16),
            planetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            planetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: planetLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func updateTableView() {
        NetworkService.requestResidents { [weak self] resident in
            DispatchQueue.main.async {
                self?.residents.append(resident)
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK: - alertButtonTapped
    @objc func alertButtonTapped() {
        let alert = UIAlertController(title: "AlertTitle", message: "AlertMessage", preferredStyle: .alert)
        let firstAlertAction = UIAlertAction(title: "FirstAlertAction", style: .default) { _ in
            print("First Alert Action")
        }
        let secondAlertAction = UIAlertAction(title: "SecondAlertAction", style: .default) { _ in
            print("Second Alert Action")
        }
        alert.addAction(firstAlertAction)
        alert.addAction(secondAlertAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "nil")
        var content = cell.defaultContentConfiguration()
        content.text = residents[indexPath.row].name
        cell.contentConfiguration = content

        return cell
    }
}

extension InfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
