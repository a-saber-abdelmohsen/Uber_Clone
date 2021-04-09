//
//  UIViewController+Extension.swift
//  Uber
//
//  Created by Ahmed Saber on 02/04/2021.
//

import UIKit

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
