//
//  AppDelegate.swift
//  Uber
//
//  Created by Ahmed Saber on 29/03/2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 13, *){
            //will use SceneDelegate
        } else {
            let userDefaults = UserDefaults.standard
            FirebaseApp.configure()
            
            //if the app is first lanched after uninstall delete current user
            if (!userDefaults.bool(forKey: "hasRunBefore")) {
                print("The app is launching for the first time. Setting UserDefaults...")
                
                do {
                    try Auth.auth().signOut()
                } catch {
                    print("Error Sig")
                }
                // Update the flag indicator
                userDefaults.set(true, forKey: "hasRunBefore")
                userDefaults.synchronize() // This forces the app to update userDefaults
                
                // Run code here for the first launch
            }
            
            let window = UIWindow()
            
            if Auth.auth().currentUser == nil {
                let signinController = SignInController()
                let navController = UINavigationController(rootViewController: signinController)
                window.rootViewController = navController
                
            } else {
                let home = HomeController()
                //            home.logOutUser()
                window.rootViewController = home
            }
            self.window = window
            self.window?.makeKeyAndVisible()
            
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available (iOS 13, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available (iOS 13, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

