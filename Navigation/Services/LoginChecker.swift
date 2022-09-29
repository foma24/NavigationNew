import Foundation

class LoginChecker {

    private let login = "test"
    private let pswd = "test"
    static let shared = LoginChecker()

    func check(login: String, password: String) -> Bool {
        if login.hash == self.login.hash && password.hash == self.pswd.hash {
            print("Correct data")
            return true
        } else {
            print("Wrong data")
            return false
        }
    }
}
