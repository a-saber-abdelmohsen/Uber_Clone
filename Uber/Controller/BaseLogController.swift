//
//  BaseLogController.swift
//  Uber
//
//  Created by Ahmed Saber on 02/04/2021.
//

import UIKit

enum LogControllerType {
    case Login
    case Signup
}

class BaseLogController: UIViewController {
    // MARK: - Proprties
    let mainButtonHeight: CGFloat = 50
    
    var logControllerType: LogControllerType? {
        didSet {
            if logControllerType == .Login {
                bottomButton.setTitle("Sign Up", for: .normal)
                bottomQLabel.text = "Don't Have an Account? "
                mainButton.setTitle("Log In", for: .normal)
                
            } else {
                bottomButton.setTitle("Log In", for: .normal)
                bottomQLabel.text = "Already Have an Account? "
                mainButton.setTitle("Sign Up", for: .normal)
            }
        }
    }
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Uber"
        label.font = .systemFont(ofSize: 48)
        label.textColor = .whiteTextColor
        return label
    }()
    
    lazy var emailContainerView: UIView = {
        return UIView().containerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextFeild, withSeparator: true)
    }()
    
    let emailTextFeild: UITextField = {
        return UITextField().logTextField(type: .Email)
    }()
    
    lazy var passwordContainerView: UIView = {
        return UIView().containerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextFeild, withSeparator: true)
    }()
    
    let passwordTextFeild: UITextField = {
        return UITextField().logTextField(type: .Password)
    }()
    
    lazy var mainButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.setTitleColor(.whiteTextColor, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .mainBlue
        button.addTarget(self, action: #selector(handleMainButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let bottomQLabel: UILabel = {
        let label = UILabel()
        label.textColor = .whiteTextColor
        return label
    }()
    
    private lazy var bottomButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(.mainBlue, for: .normal)
        button.addTarget(self, action: #selector(handleBottomButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private var bottomStack: UIStackView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBackgroundColor
        configureUI()
    }
    
    // MARK: - Handlers
    func configureUI() {
        configureNavigationController()
        view.addSubview(titleLable)
        
        titleLable.anchor(top: view.layoutMarginsGuide.topAnchor, bottom: nil, leading: nil,
                          trailing: nil, height: nil)
        titleLable.centerwith(centerX: view.centerXAnchor)
        
        bottomStack = UIStackView(arrangedSubviews: [bottomQLabel, bottomButton])
        bottomStack.axis = .horizontal
        view.addSubview(bottomStack)
        
        bottomStack.centerwith(centerX: view.centerXAnchor)
        bottomStack.anchor(top: nil, bottom: view.layoutMarginsGuide.bottomAnchor,
                           leading: nil, trailing: nil, height: nil)
    }
    
    private func configureNavigationController(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    //fuctions to override
    func logInPressed() {}
    
    func signUpPressed() {}
    
    func buttomButtonLogin() {}
    
    func buttomButtonSignup() {}
    
    // MARK: - Selectors
    @objc func handleMainButtonPressed(){
        guard let type = logControllerType else {return}
        if type == .Login {
            logInPressed()
        } else {
            signUpPressed()
        }
    }
    
    @objc func handleBottomButtonPressed(){
        guard let type = logControllerType else {return}
        if type == .Login {
            buttomButtonSignup()
        } else {
            buttomButtonLogin()
        }
    }
}
