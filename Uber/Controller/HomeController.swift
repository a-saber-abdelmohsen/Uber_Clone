//
//  HomeController.swift
//  Uber
//
//  Created by Ahmed Saber on 03/04/2021.
//

import UIKit
import FirebaseAuth
import MapKit

class HomeController: UIViewController {

    // MARK: - Properties
    var user: User? {
        didSet {
            
        }
    }
    
    let regionCoordinates: Double = 1000
    
    private let mapBackView = MKMapView()
    private let locationMagager = CLLocationManager()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        configureUI()
    }
    
    // MARK: - Handlers
    func logOutUser() {
        do {
            try Auth.auth().signOut()
            //navigate to log in view controller
            
        }catch {
            showAlert(with: .cannotLogOut)
        }
    }
    
    func configureUI() {
        setupMapView()
    }
    
    func setupMapView() {
        coverAllView(with: mapBackView)
        mapBackView.showsUserLocation = true
        mapBackView.userTrackingMode = .follow
        
    }
    
    func updateLoctionOnMap() {
        mapBackView.region = .init(center: mapBackView.userLocation.coordinate,
                                   latitudinalMeters: regionCoordinates, longitudinalMeters: regionCoordinates)
    }
    
    func setupLocationManager(){
        locationMagager.delegate = self
        locationMagager.startUpdatingLocation()
        locationMagager.desiredAccuracy = kCLLocationAccuracyBest
    }
}


extension HomeController: CLLocationManagerDelegate {
    func enableLocationAuthorization() {
        //ONLY @available(iOS 14.0, *)
        if #available(iOS 14, *){
            checkLocationAuthorization(with: locationMagager.authorizationStatus)
        }else {
            //@available(iOS, introduced: 4.2, deprecated: 14.0)
            let auth = CLLocationManager.authorizationStatus()
            checkLocationAuthorization(with: auth)
        }
    }
    
    private func checkLocationAuthorization(with auth: CLAuthorizationStatus) {
        switch auth {
        case .notDetermined:
            locationMagager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            showAlert(with: .locationServiceDenied)
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        @unknown default: fatalError("unknown: CLAuthori zationStatus")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationMagager.requestAlwaysAuthorization()
        }
        updateLoctionOnMap()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        //if user choosed alow Once this function is not goning to be invoked
        updateLoctionOnMap()
        locationMagager.requestAlwaysAuthorization()
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            enableLocationAuthorization()
        } else {
            //enable GPS Alert
            showAlert(with: .locationServicesDisables)
        }
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    
}
