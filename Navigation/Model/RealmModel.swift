import Foundation
import RealmSwift

class RealmUser: Object {

    @Persisted var login: String
    @Persisted var password: String
    @Persisted var isLogged: Bool = false
}

class RealmModel {

    static var user: RealmUser {
        do{
            let realm = try Realm()
            if !realm.objects(RealmUser.self).isEmpty {
                return realm.objects(RealmUser.self)[0]
            } else {
                let user = RealmUser()
                
                return user
            }
        } catch {
            let user = RealmUser()
            print(error.localizedDescription)
            
            return user
        }
    }

    static func saveRealmUser(_ login: String, _ password: String) {
        let user = RealmUser()
        user.login = login
        user.password = password
        user.isLogged = true
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(user)
                print("User added")
            }
        } catch {
            print(error.localizedDescription)
        }
    }

}
