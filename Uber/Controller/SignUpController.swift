//
//  SignUpController.swift
//  Uber
//
//  Created by Ahmed Saber on 02/04/2021.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

enum AccountType: Int, CustomStringConvertible {
    
    case Rider = 0
    case Driver = 1
    
    var description: String {
        switch self {
        case .Rider: return "Rider"
        case .Driver: return "Driver"
        }
    }
}

class SignUpController: BaseLogController {
    // MARK: - Properties
    //mainButton for Sign up Button
    //emailContainerView //emailTextFeild //passwordContainerView //passwordTextFeild
    
    lazy var fullNameTextField: UITextField = {
        let field = UITextField().logTextField(type: .FullName)
        field.delegate = self
        return field
    }()
    
    lazy var fullNameContainerView: UIView = {
        return UIView().containerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullNameTextField, withSeparator: true)
    }()
    
    let personImageView: UIView = {
        return UIView().containerView(withImage: #imageLiteral(resourceName: "ic_account_box_white_2x"), withSeparator: false)
    }()
    
    let typeSegmentController: UISegmentedControl = {
        let sc = UISegmentedControl(items: [AccountType.Rider.description, AccountType.Driver.description])
        sc.selectedSegmentIndex = AccountType.Rider.rawValue
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
        
        fieldsStack.dimensions(height: 230, width: view.frame.width - 32)
        fieldsStack.centerwith(centerX: view.centerXAnchor, centerY: view.centerYAnchor, topConstant: -40)
        
        mainButton.anchor(top: fieldsStack.bottomAnchor, leading: fieldsStack.leadingAnchor,
                          trailing: fieldsStack.trailingAnchor, topPadding: 24)
        mainButton.dimensions(height: mainButtonHeight)
    }
    
    // MARK: - Selectors
    override func signUpPressed() {
        if emailTextFeild.text == "" || passwordTextField.text == "" || fullNameTextField.text == "" {
            showAlert(with: .emptyField)
            return
        }
        guard let email = emailTextFeild.text else {return}
        guard let fullName = fullNameTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        let accountType = typeSegmentController.selectedSegmentIndex
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let _ = error {
                self.showAlert(with: .wrongEmail)
                return
            }
            //log in with the user
            guard let userId = result?.user.uid  else {return}
            let values: [String: Any] = ["email": email,
                                         "fullName": fullName,
                                         "accountType": accountType,
                                         "password": password]
        
            //works with realtime database
            USERS_REF.child(userId).updateChildValues(values) { (error, ref) in
                if let error = error {
                    print("Error: update user's info", error)
                    //sgin in anyway or may ask for the info one more time
                }
            }
            //log in the user
            self.userDidLogin()
        }
        
    }
    
    override func buttomButtonLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
