//
//  LocationInputTextField.swift
//  Uber
//
//  Created by Ahmed Saber on 05/04/2021.
//

import UIKit


class LocationTextField: UITextField {

    // MARK: - Properties
    private let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        borderStyle = .roundedRect
        returnKeyType = .search
        clearButtonMode = .whileEditing
        dimensions(height: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
