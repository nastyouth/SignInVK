//
//  ProfileViewController.swift
//  SignInVK
//
//  Created by Анастасия on 03.04.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import UIKit
import SwiftyVK

class ProfileViewController: UIViewController {
    
    let apiHandler = APIHandler()
    var usersInfo = [User]()
    var friendsInfo = [User]()
    var friendsInfoArray = [String]()
    
    let userInfoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    let userFriendsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    let userPhoto: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 62.5
        image.clipsToBounds = true
        return image
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 21.0)
        return label
    }()
    
    let userDomainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 19.0)
        return label
    }()
    
    let userUnivesityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        return label
    }()
    
    let userFriendsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.numberOfLines = 10;
        return label
    }()
    
    let logOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.setTitle("Выйти из ВК", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
        
        self.view.addSubview(userInfoView)
        self.view.addSubview(userFriendsView)
        self.view.addSubview(userNameLabel)
        self.view.addSubview(userDomainLabel)
        self.view.addSubview(userPhoto)
        self.view.addSubview(userFriendsLabel)
        self.view.addSubview(userUnivesityLabel)
        self.view.addSubview(logOutButton)
        
        userInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userInfoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        userInfoView.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
        userInfoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true

        userPhoto.centerXAnchor.constraint(equalTo: userInfoView.centerXAnchor).isActive = true
        userPhoto.topAnchor.constraint(equalTo: userInfoView.topAnchor, constant: 10).isActive = true
        userPhoto.heightAnchor.constraint(equalToConstant: 125).isActive = true
        userPhoto.widthAnchor.constraint(equalToConstant: 125).isActive = true
        
        userNameLabel.topAnchor.constraint(equalTo: userPhoto.bottomAnchor, constant: 10).isActive = true
        userNameLabel.centerXAnchor.constraint(equalTo: userInfoView.centerXAnchor).isActive = true
        
        userDomainLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10).isActive = true
        userDomainLabel.centerXAnchor.constraint(equalTo: userInfoView.centerXAnchor).isActive = true
        
        userUnivesityLabel.topAnchor.constraint(equalTo: userDomainLabel.bottomAnchor, constant: 10).isActive = true
        userUnivesityLabel.centerXAnchor.constraint(equalTo: userInfoView.centerXAnchor).isActive = true
        
        userFriendsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userFriendsView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: 15).isActive = true
        userFriendsView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        userFriendsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        
        userFriendsLabel.topAnchor.constraint(equalTo: userFriendsView.topAnchor, constant: 15).isActive = true
        userFriendsLabel.centerXAnchor.constraint(equalTo: userFriendsView.centerXAnchor).isActive = true
        
        logOutButton.topAnchor.constraint(equalTo: userFriendsView.bottomAnchor, constant: 15).isActive = true
        logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logOutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.09815927595, green: 0.09795580059, blue: 0.1066108719, alpha: 1)
        requestToUserApi() { _ in
            DispatchQueue.main.async {
                
                self.userNameLabel.text = self.usersInfo[0].firstName + " " + self.usersInfo[0].lastName
                self.userDomainLabel.text = "@" + self.usersInfo[0].domain
                self.userUnivesityLabel.text = "👩‍🎓" + (self.usersInfo[0].universityName ?? "")
                
                let url = URL(string: self.usersInfo[0].photo200 ?? "")
                guard let photoUrl = url else { return }
                let data = try? Data(contentsOf: photoUrl)
                guard let photoData = data else { return }
                self.userPhoto.image = UIImage(data: photoData)
            }
        }
        
        requestToFriendsApi() { _ in
            DispatchQueue.main.async {
                for i in 0..<self.friendsInfo.count {
                    self.friendsInfoArray.append("\(i+1). " + self.friendsInfo[i].firstName + " " + self.friendsInfo[i].lastName)
                }
                
                let friendsList = self.friendsInfoArray.joined(separator: "\n")
                self.userFriendsLabel.text = """
                Список друзей:
                \(friendsList)
                """
            }
        }
    }
    
    @objc func logOut() {
        VK.sessions.default.logOut()
        
        DispatchQueue.main.async {
            self.view.window?.rootViewController = ViewController()
        }
    }
    
    func requestToUserApi(completion: @escaping (Result<[User]?, Error>) -> Void) {
        
        apiHandler.getUserInfo() { [weak self] result in
        guard let sSelf = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let usersInfo):
                    sSelf.usersInfo = usersInfo ?? []
                    completion(result)
                case .failure(let error):
                     print(error)
                }
            }
        }
    }
    
    func requestToFriendsApi(completion: @escaping (Result<[User]?, Error>) -> Void) {
        
        apiHandler.getFriends() { [weak self] result in
        guard let sSelf = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let friendsInfo):
                    sSelf.friendsInfo = friendsInfo ?? []
                    completion(result)
                case .failure(let error):
                     print(error)
                }
            }
        }
    }
}
