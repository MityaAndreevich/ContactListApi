//
//  NetworkManager.swift
//  ContactListApi
//
//  Created by Dmitry Logachev on 15.12.2021.
//

import Foundation

enum Link: String {
    case linkFor1 = "https://randomuser.me/api/"
    case linkFor10 = "https://randomuser.me/api/?results=10"
    case linkFor50 = "https://randomuser.me/api/?results=50"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchData(from url: String, completion: @escaping(Result<Contact, NetworkError>) -> Void) {
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
                let decoder = JSONDecoder()
                let contacts = try decoder.decode(Contact.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(contacts))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetch<T: Decodable>(dataType: T.Type, from url: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No errror description")
                return
            }
            do {
                let decoder = JSONDecoder()
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
                print(error)
            }
        }.resume()
    }
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        return try? Data(contentsOf: imageURL)
    }
}

