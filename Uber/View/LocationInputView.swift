//
//  LocationInputView.swift
//  Uber
//
//  Created by Ahmed Saber on 04/04/2021.
//

import UIKit
protocol LocationInputViewDelegate: class {
    func dismissLocationInputView()
}

class LocationInputView: UIView {
    // MARK: - Properties
    var user: User? {
        didSet {
            userLabel.text = "For \(user?.fullName ?? "Me")"
        }
    }
    
    weak var delegate: LocationInputViewDelegate?
    
    private let userLabel: UILabel = {
        //make it a button to add the switch account functionality later
        let label = UILabel()
        label.text = "For Me"
        label.textColor = .darkGray
        return label
    }()
    
    let fromTextField: LocationTextField = {
        let field = LocationTextField()
        field.placeholder = "Enter pickup location"
        field.backgroundColor = .darkLabelGray
        return field
    }()
    
    let toTextField: LocationTextField = {
        let field = LocationTextField()
        field.placeholder = "Where to?"
        field.backgroundColor = .lightLabelGray
        return field
    }()
    
    let circleview: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.dimensions(height: 6, width: 6)
        view.layer.cornerRadius = 3
        return view
    }()
    
    let sqaureView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.dimensions(height: 6, width: 6)
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_black_36dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.dimensions(height: 30, width: 30)
        button.addTarget(self, action: #selector(handleButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentStack: UIStackView = {
        let fieldsStack = UIStackView(arrangedSubviews: [fromTextField, toTextField])
        fieldsStack.axis = .vertical
        fieldsStack.spacing = 15
        
        let lineView = UIView()
        lineView.dimensions(height: 35, width: 1)
        lineView.backgroundColor = .gray
        let shapesStack = UIStackView(arrangedSubviews: [circleview, lineView, sqaureView])
        shapesStack.axis = .vertical
        shapesStack.spacing = 2
        shapesStack.alignment = .center
        
        let stack = UIStackView(arrangedSubviews: [shapesStack, fieldsStack])
        stack.spacing = 16
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addShadow()
        //animate that when the app loads
        alpha = 0
        
        addSubview(userLabel)
        userLabel.anchor(top: safeAreaLayoutGuide.topAnchor, topPadding: 6)
        userLabel.centerwith(centerX: centerXAnchor)
        
        addSubview(backButton)
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor,
                          leading: safeAreaLayoutGuide.leadingAnchor,
                          leadingPadding: 8)
        
        addSubview(contentStack)
        contentStack.anchor(bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor,
                            bottomPadding: 12, leadingPadding: 20, trailingPadding: 20)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selector
    @objc func handleButtonPressed() {
        toTextField.resignFirstResponder()
        fromTextField.resignFirstResponder()
        delegate?.dismissLocationInputView()
    }

}
