//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Kuat Bodikov on 18.01.2022.
//

import Foundation
import Alamofire

enum Link: String {
    case mainUrl = "https://api.openweathermap.org/data/2.5/onecall?lat=50.265108&lon=57.205390&exclude=minutely,alerts,hourly&units=metric&lang=ru&appid=4ef2e9edd95153ca4989b50f0fafc65f"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}


class NetworkManager {
    static var shared = NetworkManager()
    private init() {}
    
    
    //    MARK: - Alamofire
    
    func fetchData(_ url: String, completion: @escaping(Result<[WeatherData], NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in

                switch dataResponse.result {
                case .success(let value):
                    let weathers = WeatherData.getWeather(from: value)
                    print(weathers)
                    completion(.success(weathers))
                case .failure:
                    completion(.failure(.decodingError))
                }
            }

    }
    
    func getImage(from url: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        AF.download(url)
            .validate()
            .responseData { response in
                switch response.result {
                    
                case .success(let value):
                    completion(.success(value))
                case .failure(_):
                    completion(.failure(.decodingError))
                }
            }
    }
}
