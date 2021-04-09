//
//  SceneDelegate.swift
//  Uber
//
//  Created by Ahmed Saber on 29/03/2021.
//

import UIKit
import Firebase
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
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
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
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

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        /*
         the app will continue to recieve location updates after it's been released
         we shoud call stopMonitoringSignificantLocationChanges()
         **/
        print("sceneDidDisconnect")
//        LocationHandler.shared.locationManager.stopMonitoringSignificantLocationChanges()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

