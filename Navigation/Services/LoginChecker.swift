import Foundation
import FirebaseAuth

class LoginChecker {

    private let login = "test@test.com"
    private let pswd = "test123456"
    lazy var loginHash = login.hash
    lazy var pswdHash = pswd.hash
    
    static let shared = LoginChecker()
    private init() {}
}

protocol CheckerServiceProtocol {
   static func checkCredentials(login: String, password: String, completion: @escaping (Bool) -> Void)
   static func signUp(login: String, password: String, completion: @escaping (Bool) -> Void)
}

struct CheckerService: CheckerServiceProtocol {

    static func checkCredentials(login: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: login, password: password) { authResult, error in
            if error == nil, authResult != nil {
                debugPrint("Authentication successful")
                completion(true)
            } else {
                debugPrint(error?.localizedDescription)
                completion(false)

            }
        }
    }

    static func signUp(login: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: login, password: password) { authResult, error in
            if error == nil, authResult != nil {
                debugPrint("Registration successful")
                completion(true)
            } else {
                debugPrint(error?.localizedDescription)
                completion(false)
            }
        }
    }

    static func signInStatus() -> Bool {
        if Auth.auth().currentUser != nil {
            return true
        } else {
            return false
        }
    }
}
