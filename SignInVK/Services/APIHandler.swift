//
//  APIHandler.swift
//  SignInVK
//
//  Created by Анастасия on 03.04.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import Foundation
import SwiftyVK

class APIHandler {
    
    func getUserInfo(completion: @escaping (Result<[User]?, Error>) -> Void) {
        
        VK.API.Users.get([.fields: "domain, bdate, photo_200, city, education"])
            .onSuccess ({ data in
                do {
                    let response = try! JSONDecoder().decode([User].self, from: data)
                    print(response)
                    completion(.success(response))
                }
            })
            .onError { error in print(error) }
            .send()
    }
    
    func getFriends(completion: @escaping (Result<[User]?, Error>) -> Void) {
        VK.API.Friends.get([.order: "hints", .count: "5", .fields: "domain, photo_200, bdate, education"])
            .onSuccess({ (data) in
                do {
                    let response = try? JSONDecoder().decode(Friends.self, from: data)
                    var friendsArray = [User]()
                    for i in 0..<5 {
                        guard let friend = response?.items[i] else { return }
                        friendsArray.append(friend)
                    }
                    completion(.success(friendsArray))
                }
            })
            .onError { error in print(error) }
            .send()
    }
}
    
