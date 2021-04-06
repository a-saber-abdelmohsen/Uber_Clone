//
//  Service.swift
//  Uber
//
//  Created by Ahmed Saber on 06/04/2021.
//

import Firebase

let DB_REF = Database.database().reference()
let USERS_REF = DB_REF.child("users")


struct Service {
    static let shared = Service()
    let uid = Auth.auth().currentUser?.uid
    
    func fetchUserInfo(completion: @escaping (User) -> Void) {
        guard let userid = uid else {return}
        USERS_REF.child(userid).observeSingleEvent(of: .value) { (snapShot) in
            guard let dictionary = snapShot.value as? [String: Any] else {return}
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
}
