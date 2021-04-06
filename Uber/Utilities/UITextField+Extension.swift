//
//  UITextField+Extension.swift
//  Uber
//
//  Created by Ahmed Saber on 02/04/2021.
//

import UIKit

enum LogTextFieldType {
    case Email
    case Password
    case FullName
}

extension UITextField {
    func logTextField (type: LogTextFieldType) -> UITextField{
        let tf = UITextField()
        tf.font = .systemFont(ofSize: 18)
        tf.borderStyle = .none
        tf.textColor = .whiteTextColor
        tf.keyboardAppearance = .dark
        tf.autocorrectionType = .no
        
        if type == .Email {
            tf.attributedPlaceholder = NSAttributedString(string: "Email",
                                                          attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        } else if type == .FullName {
            tf.attributedPlaceholder = NSAttributedString(string: "Full Name",
                                                          attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        } else {
            
            tf.attributedPlaceholder = NSAttributedString(string: "Password",
                                                          attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        }
        
        return tf
    }
}

