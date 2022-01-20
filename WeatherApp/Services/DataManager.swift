//
//  DataManager.swift
//  WeatherApp
//
//  Created by Kuat Bodikov on 18.01.2022.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    var cities = CityWeather(cities: [Cities(cityName: "Актобе", cityUrl: "https://api.openweathermap.org/data/2.5/onecall?lat=50.265108&lon=57.205390&exclude=minutely,alerts,hourly&units=metric&lang=ru&appid=4ef2e9edd95153ca4989b50f0fafc65f"),
                               Cities(cityName: "Москва", cityUrl: "https://api.openweathermap.org/data/2.5/onecall?lat=55.751244&lon=37.618423&exclude=minutely,alerts,hourly&units=metric&lang=ru&appid=4ef2e9edd95153ca4989b50f0fafc65f")
                              ]
    )
    
}

