//
//  HomeController.swift
//  Uber
//
//  Created by Ahmed Saber on 03/04/2021.
//

import UIKit
import FirebaseAuth

class HomeController: UIViewController {

    // MARK: - Properties
    var user: User? {
        didSet {
            
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
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

}
