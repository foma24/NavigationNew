import Foundation

class LoginChecker {

    private let login = "test@test.com"
    private let pswd = "test123456"
    static let shared = LoginChecker()

    func check(login: String, password: String) -> Bool {
        if login.hash == self.login.hash && password.hash == self.pswd.hash {
            print("Data is correct")
            return true
        } else {
            return false
        }
    }
}
