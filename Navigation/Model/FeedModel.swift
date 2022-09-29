import Foundation

class FeedModel {
    static let shared = FeedModel()
    let password: String = "Password"
    var getPassword: String = ""
    
    //init() {}
    
    func check() {
        let notify = NotificationCenter.default
        if getPassword == password {
            notify.post(name: Notification.Name("Correct"), object: nil)
        } else {
            notify.post(name: Notification.Name("Wrong"), object: nil)
        }
    }
}
