//
//  HomeController.swift
//  Uber
//
//  Created by Ahmed Saber on 03/04/2021.
//

import UIKit
import FirebaseAuth
import MapKit
import GeoFire

private let locationInputViewHeight: CGFloat = 170
private let cellId = "locationCell"

let mapBackView = MKMapView()
var currentUser: User?
let regionCoordinates: Double = 1000

class HomeController: UIViewController {
    // MARK: - Properties
    
    var tableView: UITableView?
    
    let inputButton = LocationInputButton()
    let locationInputView = LocationInputView()
    
    lazy var locateUserButton: UIButton = {
        let button = UIButton(type: .system)
        button.dimensions(height: 60, width: 60)
        button.layer.cornerRadius = 30
        let imageconfig = UIImage.SymbolConfiguration(pointSize: 40)
        button.setImage(UIImage(systemName: "dot.arrowtriangles.up.right.down.left.circle",withConfiguration: imageconfig)?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal),
                        for: .normal)
        button.contentMode = .scaleAspectFill
        button.addShadow()
        button.addTarget(self, action: #selector(locateUserButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationHandler.shared.alertDelegate = self
        LocationHandler.shared.checkLocationServices()
        configureUI()
        fetchUserInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1) {
            self.inputButton.alpha = 1
        }
    }
    
    // MARK: - Handlers
    
    func configureUI() {
        setupMapView()
        setupInputButton()
        setuplocationInputView()
        
        view.addSubview(locateUserButton)
        locateUserButton.anchor(bottom: view.bottomAnchor, trailing: view.trailingAnchor, bottomPadding: 60, trailingPadding: 30)
    }
    
    func setupMapView() {
        coverAllView(with: mapBackView)
        mapBackView.showsUserLocation = true
        mapBackView.userTrackingMode = .follow
        mapBackView.delegate = MapDelegate.mapDelegate
    }
    
    func setuplocationInputView() {
        locationInputView.delegate = self
        view.addSubview(locationInputView)
        locationInputView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        locationInputView.dimensions(height: locationInputViewHeight)
        locationInputView.fromTextField.delegate = self
        locationInputView.toTextField.delegate = self
    }
    
    func setupInputButton() {
        view.addSubview(inputButton)
        inputButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, topPadding: 64)
        inputButton.centerwith(centerX: view.centerXAnchor)
        inputButton.dimensions(height: 42, width: view.frame.width - 32)
        inputButton.addTarget(self, action: #selector(inputButtonPressed), for: .touchUpInside)
    }
    
    func setupTableView(){
        let frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width,
                           height: view.frame.height - locationInputViewHeight)
        tableView = UITableView(frame: frame, style: .plain)
        view.addSubview(tableView!)
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView?.rowHeight = 60
        tableView?.tableFooterView = UIView()
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    // MARK: - Selectors
    @objc func inputButtonPressed(){
        //hide inputButton and show inputView
        showButtonHideView(reverse: true)
        locationInputView.fromTextField.becomeFirstResponder()
    }
    
    @objc func locateUserButtonPressed(){
        LocationHandler.shared.updateLoctionOnMap()
        mapBackView.userTrackingMode = .follow
        LocationHandler.shared.locationManager.requestLocation()
    }
    
    
    // MARK: - API
    func fetchUserInfo() {
        Service.shared.fetchUserInfo { (user) in
            self.locationInputView.user = user
            currentUser = user
        }
    }
    
    func logOutUser() {
        do {
            try Auth.auth().signOut()
            //navigate to log in view controller
            
        }catch {
            showAlert(with: .cannotLogOut)
        }
    }
}

extension HomeController: LocationHandlerAlertDelegate {
    //already implemented in UIViewController Extension
    //func showAlert(with message: ErrorMessages)
}

extension HomeController: LocationInputViewDelegate {
    func dismissLocationInputView() {
        showButtonHideView(reverse: false)
    }
    
    func showButtonHideView(reverse: Bool) {
        if reverse {
            setupTableView()
        }
        UIView.animate(withDuration: 0.3) {
            self.inputButton.alpha = reverse ? 0 : 1
            self.locationInputView.alpha = reverse ? 1 : 0
            if !reverse {
                self.tableView?.frame = CGRect(x: 0, y: self.view.frame.height,
                                               width: self.view.frame.width, height: 0)
            }
        } completion: { (_) in
            if reverse {
                UIView.animate(withDuration: 0.2) {
                    self.tableView?.frame = CGRect(x: 0, y: locationInputViewHeight + 0.3,
                                                   width: self.view.frame.width,
                                                   height: self.view.frame.height - locationInputViewHeight)
                } completion: { (_) in
                    if !reverse {
                        self.tableView?.removeFromSuperview()
                        self.tableView = nil
                    }
                }
            }
        }
    }
}

extension HomeController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == locationInputView.fromTextField {
            locationInputView.fromTextField.backgroundColor = .darkLabelGray
            locationInputView.toTextField.backgroundColor = .lightLabelGray
            locationInputView.circleview.backgroundColor = .black
            locationInputView.sqaureView.backgroundColor = .gray
        } else {
            locationInputView.fromTextField.backgroundColor = .lightLabelGray
            locationInputView.toTextField.backgroundColor = .darkLabelGray
            locationInputView.circleview.backgroundColor = .gray
            locationInputView.sqaureView.backgroundColor = .black
        }
    }
}



extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        return cell
    }
}
