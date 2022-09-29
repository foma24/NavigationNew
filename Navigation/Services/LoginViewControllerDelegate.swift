import Foundation
import UIKit

protocol LoginViewControllerDelegate{
     func check(login: String, password: String) -> Bool
}
