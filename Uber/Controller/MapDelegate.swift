//
//  MapKitDelegate.swift
//  Uber
//
//  Created by Ahmed Saber on 08/04/2021.
//

import MapKit
let driverReuseIdentifier = "driverReuseIdentifier"

class MapDelegate:NSObject, MKMapViewDelegate {
    
    static let mapDelegate = MapDelegate()
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? DriverAnnotation {
            let view = MKAnnotationView(annotation: annotation, reuseIdentifier: driverReuseIdentifier)
            view.image = #imageLiteral(resourceName: "chevron-sign-to-right").withRenderingMode(.alwaysOriginal)
            view.accessibilityIdentifier = annotation.driverId
            return view
        }
        return nil
    }
}
