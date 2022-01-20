//
//  CityModel.swift
//  WeatherApp
//
//  Created by Kuat Bodikov on 18.01.2022.
//

import Foundation

// MARK: - Cities
struct CityWeather {
    let cities: [Cities]
}

struct Cities {
    let cityName: String
    let cityUrl: String
}

extension CityWeather {
     
    static func getCity() -> CityWeather {
        let cities: CityWeather = DataManager.shared.cities
        return cities
    }
}
