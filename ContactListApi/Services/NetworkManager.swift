//
//  NetworkManager.swift
//  ContactListApi
//
//  Created by Dmitry Logachev on 15.12.2021.
//

import Foundation

enum Link: String {
    case linkFor1 = "https://randomuser.me/api/"
    case LinkFor20 = "https://randomuser.me/api/?results=20"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchUser(from url: String, completion: @escaping(Result<Contact, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No Error Description")
                return
            }
            do {
                let userContact = try JSONDecoder().decode(Contact.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(userContact))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

