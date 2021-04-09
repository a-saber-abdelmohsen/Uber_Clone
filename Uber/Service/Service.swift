//
//  Service.swift
//  Uber
//
//  Created by Ahmed Saber on 06/04/2021.
//

import Foundation
import Firebase
import GeoFire

let DB_REF = Database.database().reference()
let USERS_REF = DB_REF.child("users")
let REF_DRIVERS_LOCATIONS = DB_REF.child("drivers-locations")

struct Service {
    static let shared = Service()
    let uid = Auth.auth().currentUser?.uid
    var geoFire = GeoFire(firebaseRef: REF_DRIVERS_LOCATIONS)
    
    func fetchUserInfo(completion: @escaping (User) -> Void) {
        guard let userid = uid else {return}
        USERS_REF.child(userid).observeSingleEvent(of: .value) { (snapShot) in
            guard let dictionary = snapShot.value as? [String: Any] else {return}
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    func updateDriver(location: CLLocation) {
        guard let uid = uid else {return}
        geoFire.setLocation(location, forKey: uid)
    }
    
    func fetchNearbyDrivers(location: CLLocation,
                            completion: @escaping (_ driver: DriverAnnotation) -> Void){
        REF_DRIVERS_LOCATIONS.observe(.value) { (_) in
            geoFire.query(at: location, withRadius: 1).observe(.keyEntered,with: { (uid, location) in
                let driver = DriverAnnotation(uid: uid, coordinate: location.coordinate)
                completion(driver)
            })
        }
    }
}
