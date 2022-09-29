import Foundation
import UIKit

class CurrentUserService: UserService {
    let user = User(login: "Nickname", fullName: "Name", avatar: UIImage(named: "mario"), status: "Status")
    
    func getUser(login: String) -> User? {
        if login == user.login{
            return user
        } else {
            return nil
        }
    }
}
