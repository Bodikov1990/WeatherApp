//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Kuat Bodikov on 18.01.2022.
//

import Foundation
import Alamofire


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}


class NetworkManager {
    static var shared = NetworkManager()
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetch<T: Decodable>(dataType: T.Type, from url: String, convertFromSnakeCase: Bool = true, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                if convertFromSnakeCase {
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                }
                
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
}
