//
//  ViewController.swift
//  SignInVK
//
//  Created by Анастасия on 03.04.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import UIKit
import SwiftyVK

class ViewController: UIViewController, SwiftyVKDelegate {
    let appId = "7388615"
    let scopes: Scopes = [.friends, .offline, .photos]
    
    func vkNeedsScopes(for sessionId: String) -> Scopes {
        return scopes
    }

    func vkNeedToPresent(viewController: VKViewController) {
        self.present(viewController, animated: true)
    }
    
    let authorizeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Авторизироваться", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(authorize), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
        view.addSubview(authorizeButton)
        authorizeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        authorizeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        authorizeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        authorizeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
    }
    
    @objc func authorize() {
        VK.sessions.default.logIn(
            onSuccess: { _ in
                DispatchQueue.main.async {
                    let profileViewController = ProfileViewController()
                    profileViewController.modalPresentationStyle = .fullScreen
                    self.present(profileViewController, animated: true)
                }
            },
            onError: { error in
              print(error)
            }
        )
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
