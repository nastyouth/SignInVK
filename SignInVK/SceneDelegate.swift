//
//  SceneDelegate.swift
//  SignInVK
//
//  Created by Анастасия on 03.04.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import UIKit
import SwiftyVK

class SceneDelegate: UIResponder, UIWindowSceneDelegate, SwiftyVKDelegate {

    var window: UIWindow?
    
    let appId = "7388615"
    let scopes: Scopes = [.friends, .offline, .photos]

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        VK.setUp(appId: appId, delegate: self)

        self.window = UIWindow(windowScene: windowScene)
        
        if VK.sessions.default.state != .authorized {
            self.window?.rootViewController = ViewController()
            self.window?.makeKeyAndVisible()
        }
        if VK.sessions.default.state == .authorized {
             self.window?.rootViewController = ProfileViewController()
             self.window?.makeKeyAndVisible()
        }
        guard let scene = (scene as? UIWindowScene) else { return }
    }
    
    func vkNeedsScopes(for sessionId: String) -> Scopes {
        return scopes
    }
       
    func vkNeedToPresent(viewController: VKViewController) {
        self.window?.rootViewController?.present(viewController, animated: true)
    }

    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

