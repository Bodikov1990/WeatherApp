//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Kuat Bodikov on 17.01.2022.
//

import Foundation


// MARK: - WeatherData
struct WeatherData: Decodable {
    let lat: Double?
    let lon: Double?
    let current: Current?
    let daily: [Daily]?
    
    init(weatherData: [String: Any]) {
        lat = weatherData["lat"] as? Double
        lon = weatherData["lon"] as? Double
        current = weatherData["current"] as? Current
        daily = weatherData["daily"] as? [Daily]
    }
    
    static func getWeather(from value: Any) -> [WeatherData] {
        guard let weathersData = value as? [[String: Any]] else { return [] }
        return weathersData.compactMap { WeatherData(weatherData: $0)}
    }
}

// MARK: - Current
struct Current: Decodable {
    let dt: Int?
    let temp: Double?
    let feelsLike: Double?
    let clouds: Int?
    let windSpeed: Double?
    let weather: [Weather]?
    
    init(currentData: [String: Any]) {
        dt = currentData["dt"] as? Int
        temp = currentData["temp"] as? Double
        feelsLike = currentData["feels_Like"] as? Double
        clouds = currentData["clouds"] as? Int
        windSpeed = currentData["wind_speed"] as? Double
        weather = currentData["weather"] as? [Weather]
    }
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int?
    let main: String?
    let weatherDescription: String?
    let icon: String?
    var conditionCode: String {
        "http://openweathermap.org/img/wn/\(icon ?? "")@2x.png"
    }
    
    init(weathersData: [String: Any]) {
        id = weathersData["id"] as? Int
        main = weathersData["main"] as? String
        weatherDescription = weathersData["description"] as? String
        icon = weathersData["icon"] as? String
    }
}

// MARK: - Daily
struct Daily: Decodable {
    let dt: Int?
    let temp: Temp?
    let feelsLike: FeelsLike?
    let windSpeed: Double?
    let weather: [Weather]?
    let clouds: Int?
    
    init(dailyData: [String: Any]) {
        dt = dailyData["dt"] as? Int
        temp = dailyData["temp"] as? Temp
        feelsLike = dailyData["feels_Like"] as? FeelsLike
        windSpeed = dailyData["wind_speed"] as? Double
        weather = dailyData["weather"] as? [Weather]
        clouds = dailyData["clouds"] as? Int
    }
}

// MARK: - FeelsLike
struct FeelsLike: Decodable {
    let day, night: Double?
    
    init(feelsData: [String: Any]) {
        day = feelsData["day"] as? Double
        night = feelsData["night"] as? Double
    }
}

// MARK: - Temp
struct Temp: Decodable {
    let day, min, max, night: Double?
    
    init(tempData: [String: Any]) {
        day = tempData["day"] as? Double
        min = tempData["min"] as? Double
        max = tempData["max"] as? Double
        night = tempData["night"] as? Double
    }
}
