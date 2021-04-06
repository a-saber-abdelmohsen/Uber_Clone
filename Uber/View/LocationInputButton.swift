//
//  LocationInputButton.swift
//  Uber
//
//  Created by Ahmed Saber on 04/04/2021.
//

import UIKit

class LocationInputButton: UIButton {
    // MARK: - Properties
    let contentStack: UIStackView = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        label.text = "Where to?"
        let squareView = UIView()
        squareView.backgroundColor = .black
        squareView.dimensions(height: 6, width: 6)
        
        let stack = UIStackView(arrangedSubviews: [squareView, label])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .center
        stack.isUserInteractionEnabled = false
        return stack
    }()
    
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        //later animate showing it up with alph = 1
        alpha = 0
        addShadow()
        
        addSubview(contentStack)
        contentStack.anchor(leading: leadingAnchor, leadingPadding: 18)
        contentStack.centerwith(centerY: centerYAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
