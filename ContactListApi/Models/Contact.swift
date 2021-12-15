//
//  Contact.swift
//  ContactListApi
//
//  Created by Dmitry Logachev on 15.12.2021.
//

import Foundation

struct Contact: Codable {
    let gender: String?
    let name: Name?
    let location: Location?
    let email: String?
    let login: Login?
    let dob: Dob?
    let registrated: Registrated?
    let phone: String?
    let cell: String?
    let id: Id?
    let picture: Picture?
    let nat: String?
}
//MARK: - Name
struct Name: Codable {
    let title: String?
    let first: String?
    let last: String?
}
//MARK: - Location
struct Location: Codable {
    let street: Street?
    let city: String?
    let state: String?
    let country: String?
    let postcode: Int?
    let coordinates: Coordinates?
    let timezone: TimeZone?
}
//MARK: - Street
struct Street: Codable {
    let number: Int?
    let name: String?
}
//MARK: - Coordinates
struct Coordinates: Codable {
    let latitude: String?
    let longitude: String?
}
//MARK: - TimeZone
struct TimeZone: Codable {
    let offset: String?
    let description: String?
}
//MARK: - Login
struct Login: Codable {
    let uuid, username, password: String?
}
//MARK: - Dob
struct Dob: Codable {
    let date: String?
    let age: Int?
}
//MARK: - Registrated
struct Registrated: Codable {
    let date: String?
    let age: Int?
}
//MARK: - ID
struct Id: Codable {
    let name, value: String?
}
//MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String?
}

