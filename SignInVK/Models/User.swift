//
//  User.swift
//  SignInVK
//
//  Created by Анастасия on 03.04.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int?
    let firstName: String
    let lastName: String
    let domain: String
    let bdate: String?
    let photo200: String?
    var universityName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case domain
        case bdate
        case photo200 = "photo_200"
        case universityName = "university_name"
    }
    
     init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.firstName = try! container.decode(String.self, forKey: .firstName)
        self.lastName = try! container.decode(String.self, forKey: .lastName)
        self.bdate = try container.decode(String.self, forKey: .bdate)
        self.domain = try container.decode(String.self, forKey: .domain)
        self.photo200 = try container.decode(String.self, forKey: .photo200)
        do {
            self.universityName = try container.decode(String.self, forKey: .universityName)
        } catch {
            self.universityName = ""
        }
    }
}
