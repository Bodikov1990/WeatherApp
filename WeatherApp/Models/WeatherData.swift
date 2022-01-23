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
    let timezoneOffset: Int?
    let current: Current?
    let daily: [Daily]?
    
}

// MARK: - Current
struct Current: Decodable {
    var dt: Int?
    let temp: Double?
    let feelsLike: Double?
    let clouds: Int?
    let windSpeed: Double?
    let weather: [Weather]?
    var title: String {
        "\(dt ?? 0)"
    }
    var temperture: String {
        """
        \(String(format: "%.00f", temp ?? 0))°C
        
        """
    }
    
    var feels: String {
        """
        Ощущается как: \(String(format: "%.00f", feelsLike ?? 0))°C
        """
    }
    
    var wind: String {
        """
        Скорость ветра: \(String(format: "%.00f", windSpeed ?? 0)) км/ч
        """
    }

}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
    var conditionCode: String {
        "http://openweathermap.org/img/wn/\(icon ?? "")@2x.png"
    }
    
    var weatherDescription: String {
        """
        \(description ?? "")
        """
    }

}

// MARK: - Daily
struct Daily: Decodable {
    let dt: Int?
    let temp: Temp
    let feelsLike: FeelsLike
    let windSpeed: Double?
    let weather: [Weather]?
    let clouds: Int?
}

// MARK: - FeelsLike
struct FeelsLike: Decodable {
    let day, night: Double?
    var feelDay: String {
        """
        Ощущение как: \(String(format: "%.00f", day ?? 0))°C
        """
    }
    
    var feelNight: String {
        "Ночью: \(String(format: "%.00f", night ?? 0))°C"
    }
}

// MARK: - Temp
struct Temp: Decodable {
    let day, min, max, night: Double?
    var dayAndNight: String {
        "\(String(format: "%.00f", day ?? 0)) / \(String(format: "%.00f", night ?? 0))"
    }
    
    var mainTemp: String {
        "\(String(format: "%.00f", day ?? 0))°C"
    }
    var dayTemp: String {
        "Днем: \(String(format: "%.00f", day ?? 0))°C"
    }
    
    var nightTemp: String {
        "Ночью: \(String(format: "%.00f", night ?? 0))°C"
    }
    
}
