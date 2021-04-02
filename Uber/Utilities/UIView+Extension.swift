//
//  UIView+Extension.swift
//  Uber
//
//  Created by Ahmed Saber on 29/03/2021.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?,
                height: NSLayoutDimension?, heightMultiplier: CGFloat = 1,
                topPadding: CGFloat = 0, bottomPadding: CGFloat = 0,
                leadingPadding: CGFloat = 0, trailingPadding: CGFloat = 0) {
        
        //Enables Autolayout to out View
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: leadingPadding).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -trailingPadding).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalTo: height, multiplier: heightMultiplier).isActive = true
        }
    }
    
    func centerwith(centerX: NSLayoutXAxisAnchor? = nil,
                    centerY: NSLayoutYAxisAnchor? = nil,
                    topConstant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY, constant: topConstant).isActive = true
        }
    }
    
    func constant(height: CGFloat = 0, width: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }

    
    func containerView(withImage image: UIImage, textField: UITextField? = nil, withSeparator: Bool) -> UIView{
        let view = UIView()
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        
        imageView.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: nil,
                         height: nil,leadingPadding: 8)
        imageView.constant(height: 24, width: 24)
        imageView.centerwith(centerY: view.centerYAnchor)
        
        if let textField = textField {
            textField.borderStyle = .none
            view.addSubview(textField)
            textField.anchor(top: nil, bottom: nil, leading: imageView.trailingAnchor,
                             trailing: view.trailingAnchor, height: nil, leadingPadding: 8)
            textField.centerwith(centerY: view.centerYAnchor)
        }
        
        if withSeparator {
            let sparatorView = UIView()
            view.addSubview(sparatorView)
            sparatorView.backgroundColor = .darkGray
            sparatorView.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor,
                                trailing: view.trailingAnchor, height: nil,
                                leadingPadding: 8, trailingPadding: 8)
            sparatorView.constant(height: 0.75)
        }
        return view
    }
}
