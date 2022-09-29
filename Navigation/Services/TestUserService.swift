import Foundation
import UIKit

class TestUserService: UserService {
    let user = User(login: "test", fullName: "testName", avatar: UIImage(named: "duck"), status: "On test!")
    
    func getUser(login: String) -> User? {
        if login == user.login{
            return user
        } else {
            return nil
        }
    }
}
