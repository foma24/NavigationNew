import Foundation
import UIKit

protocol LoginViewControllerDelegate{
    func check(username: String, password: String, completion: @escaping (Bool) -> Void)
    func create(username: String, password: String, completion: @escaping (Bool) -> Void)
}
