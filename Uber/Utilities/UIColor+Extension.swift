//
//  UIColor+Extension.swift
//  Uber
//
//  Created by Ahmed Saber on 29/03/2021.
//

import UIKit

extension UIColor {
    func rgb(_ red: CGFloat, _ green: CGFloat,_ blue: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
    }
    
    static let darkBackgroundColor = UIColor().rgb(25, 25, 25)
    static let whiteTextColor = UIColor(white: 1, alpha: 0.87)
    static let mainBlue = UIColor().rgb(17, 154, 237)
    static let lightLabelGray = UIColor().rgb(240, 240, 240)
    static let darkLabelGray = UIColor().rgb(210, 210, 210)
    
}
