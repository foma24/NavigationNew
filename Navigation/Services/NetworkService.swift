import Foundation

struct NetworkService {
    //MARK: - request
    static func request(for configuration: AppConfiguration) {
        guard let url: URL = configuration.url else { preconditionFailure() }
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
    
    static func request(id: Int, completion: @escaping (String) -> Void) {
        guard let url: URL = URL(string: ("https://jsonplaceholder.typicode.com/todos/" + String(id))) else { preconditionFailure() }
        let urlTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do{
                    let object = try JSONSerialization.jsonObject(with: data, options: [])
                    if let idInfo = object as? [String : Any] {
                        guard let title = idInfo["title"] as? String else { return }
                        completion(title)
                    }
                } catch let error {
                    print("Error discription: \(error)")
                }
            }
        }
        urlTask.resume()
    }
    
    static func request(completion: @escaping (PlanetModel) -> Void) {
        guard let url: URL = URL(string: "https://swapi.dev/api/planets/1") else { preconditionFailure() }
        let urlTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let planet = try JSONDecoder().decode(PlanetModel.self, from: data)
                    completion(planet)
                } catch let error {
                    print("Error discription: \(error)")
                }
            }
        }
        urlTask.resume()
    }
    
    static func requestResidents(completion: @escaping (Residents) -> Void) {
        NetworkService.request { planet in
            planet.residentsURL?.forEach { residentURL in
                let urlTask = URLSession.shared.dataTask(with: residentURL) { data, response, error in
                    if let data = data {
                        do {
                            let resident = try JSONDecoder().decode(Residents.self, from: data)
                            completion(resident)
                        } catch let error {
                            print("Error discription: \(error)")
                        }
                    }
                }
                urlTask.resume()
            }
        }
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
