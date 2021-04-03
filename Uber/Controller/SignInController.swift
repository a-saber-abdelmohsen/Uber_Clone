//
//  ViewController.swift
//  Uber
//
//  Created by Ahmed Saber on 29/03/2021.
//

import UIKit
import FirebaseAuth

class SignInController: BaseLogController {
    // MARK: - Properties
    //mainButton for Log In Button
    //emailContainerView //emailTextFeild //passwordContainerView //passwordTextFeild
    
    var fieldsStack: UIStackView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Handlers
    override func configureUI() {
        logControllerType = .Login
        super.configureUI()
        
        fieldsStack = UIStackView(arrangedSubviews: [emailContainerView,
                                                     passwordContainerView])
        fieldsStack.distribution = .fillEqually
        fieldsStack.spacing = 10
        fieldsStack.axis = .vertical
        view.addSubview(fieldsStack)
        view.addSubview(mainButton)
        
        //take the same width in both Orientation related to screen width
        if let window = UIApplication.shared.windows.first {
            if let scene = window.windowScene {
                if scene.interfaceOrientation.isPortrait {
                    fieldsStack.constant(height: 90, width: view.frame.width - 32)
                } else {
                    fieldsStack.constant(height: 90, width: view.frame.height - 32)
                }
            }
        }
        fieldsStack.centerwith(centerX: view.centerXAnchor, centerY: view.centerYAnchor, topConstant: -60)
        
        mainButton.anchor(top: fieldsStack.bottomAnchor, bottom: nil, leading: fieldsStack.leadingAnchor, trailing: fieldsStack.trailingAnchor, height: nil, topPadding: 24)
        mainButton.constant(height: mainButtonHeight)
    }
    
    // MARK: - Selectors
    override func logInPressed() {
        if emailTextFeild.text == "" || passwordTextField.text == "" {
            showAlert(with: .emptyEmailorPassword)
            return
        }
        guard let email = emailTextFeild.text else {return}
        guard let password = passwordTextField.text else {return}
        
        //log in with user for
        Auth.auth().signIn(withEmail: email, password: password) { (result, errer) in
            if errer != nil {
                self.showAlert(with: .wrongEmail)
                return
            }
            //log the user in
            self.userDidLogin(user: result?.user)
        }
    }
    
    override func buttomButtonSignup() {
        let signupController = SignUpController()
        navigationController?.pushViewController(signupController, animated: true)
    }
}

