//
//  UserModel.swift
//  demo
//
//  Created by CMTech on 12/4/22.
//

import UIKit




// MARK: - User
struct User: Codable {
    let id: Int?
    let name, username, email: String?
    let address: Address?
    let phone, website: String?
    let company: Company?
    var isfav: Bool?
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String?
    let geo: Geo?
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String?
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String?
}

typealias Users = [User]
// typealias  UserDetailsModel = User







