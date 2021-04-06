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
        
        fieldsStack.dimensions(height: 90, width: view.frame.width - 32)
        
        fieldsStack.centerwith(centerX: view.centerXAnchor, centerY: view.centerYAnchor, topConstant: -60)
        
        mainButton.anchor(top: fieldsStack.bottomAnchor, leading: fieldsStack.leadingAnchor,
                          trailing: fieldsStack.trailingAnchor, topPadding: 24)
        mainButton.dimensions(height: mainButtonHeight)
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
            self.userDidLogin()
        }
    }
    
    override func buttomButtonSignup() {
        let signupController = SignUpController()
        navigationController?.pushViewController(signupController, animated: true)
    }
}

