//
//  LocationManager.swift
//  Uber
//
//  Created by Ahmed Saber on 06/04/2021.
//

import UIKit
import CoreLocation

protocol LocationHandlerAlertDelegate {
    //already implemented in UIViewController Extension
    func showAlert(with message: ErrorMessages)
}

class LocationHandler: NSObject, CLLocationManagerDelegate {
    
    // MARK: - Properties
    static let shared = LocationHandler()
    var locationManager: CLLocationManager!
    
    let updateRate: TimeInterval = 10
    var requestTime: Timer?
    
    lazy var location = locationManager.location {
        didSet {
            if location == oldValue { /*no need to update location**/return}
            guard let location = location else {return}
            guard let user = currentUser else {return}
            if user.accountType == .Driver {
                Service.shared.updateDriver(location: location)
            } else {
                Service.shared.fetchNearbyDrivers(location: location) { (driver) in
                    var isDriverShown: Bool {
                        return mapBackView.annotations.contains { (annotation) -> Bool in
                            guard let annotation = annotation as? DriverAnnotation else {return false}
                            if  annotation.driverId == driver.driverId {
                                //animate update annotation location
                                UIView.animate(withDuration: 0.1) {
                                    annotation.coordinate = driver.coordinate
                                }
                                return true
                            }
                            return false
                        }
                    }
                    if !isDriverShown {
                        mapBackView.addAnnotation(driver)
                    }
                }
            }
            
        }
    }
    var alertDelegate: LocationHandlerAlertDelegate?
    
    // MARK: - Init
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    // MARK: - Handlers
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            enableLocationAuthorization()
        } else {
            //enable GPS Alert
            //Alert with sittings button Would Show Automatically to tell the User if He/She wants 
            alertDelegate?.showAlert(with: .locationServicesDisables)
        }
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        /*
         **
         I think it's a bad idea to use locationManager.startUpdatingLocation()
         as it will drain the user’s battery and also drain the user’s internet if he/she is a driver
         as updating the driver location so i think it's a good idea to use some low rate
         but it has its downfall "the time will be but to sleep while the app is in the back ground"
         **
         we also can use locationManager.startMonitoringSignificantLocationChanges()
         but it's a very slow rate /roughly around 500 meters or after some fixed time say 5 minutes/
         **
         TODO: TRY TO FIND THE BEST SOLUTION
         **/
        locationManager.allowsBackgroundLocationUpdates = true
//        requestTime = Timer.scheduledTimer(timeInterval: updateRate, target: self, selector: #selector(requestLocation), userInfo: nil, repeats: true)
//        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
    }
    
//    @objc func requestLocation(){
//        locationManager.requestLocation()
//    }
    
    func enableLocationAuthorization() {
        //ONLY @available(iOS 14.0, *)
        if #available(iOS 14, *){
            checkLocationAuthorization(with: locationManager.authorizationStatus)
        }else {
            //@available(iOS, introduced: 4.2, deprecated: 14.0)
            let auth = CLLocationManager.authorizationStatus()
            checkLocationAuthorization(with: auth)
        }
    }
    
    private func checkLocationAuthorization(with auth: CLAuthorizationStatus) {
        switch auth {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            alertDelegate?.showAlert(with: .locationServiceDenied)
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        @unknown default: fatalError("unknown: CLAuthorizationStatus")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
        updateLoctionOnMap()
    }
    
    //deprecated IOS14
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        //if user choosed alow Once this function is not goning to be invoked
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
        updateLoctionOnMap()
    }
    
    func updateLoctionOnMap() {
        mapBackView.region = .init(center: mapBackView.userLocation.coordinate,
                                   latitudinalMeters: regionCoordinates, longitudinalMeters: regionCoordinates)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //must implement but for now i dont really need it
    }

}
