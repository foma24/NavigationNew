import Foundation

class LoginFactory: LoginFactoryProtocol {
    func createLoginInspector() -> LoginInspector {
        let inspector = LoginInspector()
        return inspector
    }
}
