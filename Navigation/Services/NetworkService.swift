import Foundation

struct NetworkService {
    //MARK: - request
    static func request(for configuration: AppConfiguration) {
        guard let url: URL = configuration.url else { return }
        let urlTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data {
                print("Recieved data: \(String(describing: String(data: data, encoding: .utf8)))")
            }
            
            if let response = response as? HTTPURLResponse {
                print("All header Fields: \n\(response.allHeaderFields)")
                print("Status code: \(response.statusCode)")
            }
            
            print("Error: \(String(describing: error))\nError discription: \(String(describing: error?.localizedDescription))")
        }
        urlTask.resume()
    }
}

//MARK: - enum AppConfiguration
enum AppConfiguration {
    case people
    case starships
    case planets
    
    var url: URL? {
        switch self {
        case .people:
            return URL(string: "https://swapi.dev/api/people/8")
        case .starships:
            return URL(string: "https://swapi.dev/api/starships/3")
        case .planets:
            return URL(string: "https://swapi.dev/api/planets/5")
        }
    }
}
