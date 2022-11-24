import Foundation
import UIKit

protocol LoginViewControllerDelegate{
    func signUp(username: String, password: String)
    func signIn(username: String, password: String)
}
