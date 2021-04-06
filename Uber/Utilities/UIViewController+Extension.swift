//
//  UIViewController+Extension.swift
//  Uber
//
//  Created by Ahmed Saber on 02/04/2021.
//

import UIKit

enum ErrorMessages: Int, CustomStringConvertible {
    case emptyEmailorPassword
    case wrongEmail
    case emptyField
    case cannotLogOut
    case locationServicesDisables
    case locationServiceDenied
    
    var description: String {
        switch self {
        case .emptyEmailorPassword: return "Please Enter the Email and the Password"
        case .wrongEmail: return "Wrong Email or Password"
        case .emptyField: return "Please Fill In Empty Fields"
        case .cannotLogOut: return "Can't Log out Please Check The Internet Connection and Try Again"
        case .locationServiceDenied: return "Uber Needs Your Location to Find You Nearby Drivers\nGo TO: Settings > Privacy > Location Services"
        case .locationServicesDisables: return "Please Enable GPS to Use Uber"
        }
    }
}


extension UIViewController {
    func showAlert(with message: ErrorMessages) {
        let alert = UIAlertController(title: "Alert", message: message.description, preferredStyle: .alert)
        //add Cancel button to alert
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    func coverAllView(with subView: UIView) {
        view.addSubview(subView)
        subView.anchor(top: view.topAnchor, bottom: view.bottomAnchor,
                       leading: view.leadingAnchor, trailing: view.trailingAnchor, height: nil)
    }
}
