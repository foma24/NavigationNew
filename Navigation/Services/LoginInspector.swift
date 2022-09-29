import Foundation

class LoginInspector: LoginViewControllerDelegate {

    func check(login: String, password: String) -> Bool {
        let data = LoginChecker.shared.check(login: login, password: password)
        if data {
            print("Такой пользователь существует")
            return true
        } else {
            print("Такого пользователя не существует")
            return false
        }
    }
}
