//
//  DriverAnnotation.swift
//  Uber
//
//  Created by Ahmed Saber on 08/04/2021.
//

import MapKit

class DriverAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var driverId: String

    init(uid: String, coordinate: CLLocationCoordinate2D) {
        self.driverId = uid
        self.coordinate = coordinate
    }
}
