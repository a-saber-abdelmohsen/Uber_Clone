//
//  SignUpController.swift
//  Uber
//
//  Created by Ahmed Saber on 02/04/2021.
//

import UIKit


class SignUpController: BaseLogController {
    // MARK: - Properties
    //mainButton for Sign up Button
    //emailContainerView //emailTextFeild //passwordContainerView //passwordTextFeild
    
    
    let fullNameTextField: UITextField = {
        return UITextField().logTextField(type: .FullName)
    }()
    
    lazy var fullNameContainerView: UIView = {
        return UIView().containerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullNameTextField, withSeparator: true)
    }()
    
    let personImageView: UIView = {
        return UIView().containerView(withImage: #imageLiteral(resourceName: "ic_account_box_white_2x"), withSeparator: false)
    }()
    
    let typeSegmentController: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Rider","Driver"])
        sc.selectedSegmentIndex = 0
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.whiteTextColor,                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .normal)
        
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,
                                   NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .selected)
        sc.selectedSegmentTintColor = .whiteTextColor
        return sc
    }()
    
    var fieldsStack: UIStackView!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Handlers
    override func configureUI() {
        logControllerType = .Signup
        super.configureUI()
        
        
        fieldsStack = UIStackView(arrangedSubviews: [emailContainerView,
                                                     fullNameContainerView,
                                                     passwordContainerView,
                                                     personImageView,
                                                     typeSegmentController])
        fieldsStack.distribution = .fillEqually
        fieldsStack.spacing = 10
        fieldsStack.axis = .vertical
        view.addSubview(fieldsStack)
        view.addSubview(mainButton)
        
        if let window = UIApplication.shared.windows.first {
            if let scene = window.windowScene {
                if scene.interfaceOrientation.isPortrait {
                    fieldsStack.constant(height: 230, width: view.frame.width - 32)
                } else {
                    fieldsStack.constant(height: 230, width: view.frame.height - 32)
                }
            }
        }
        
        fieldsStack.centerwith(centerX: view.centerXAnchor, centerY: view.centerYAnchor, topConstant: -40)
        
        mainButton.anchor(top: fieldsStack.bottomAnchor, bottom: nil, leading: fieldsStack.leadingAnchor, trailing: fieldsStack.trailingAnchor, height: nil, topPadding: 24)
        mainButton.constant(height: mainButtonHeight)
    }
    
    // MARK: - Selectors
    override func signUpPressed() {
        print("Sign Up")
    }
    
    override func buttomButtonLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
