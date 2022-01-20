//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kuat Bodikov on 20.01.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var feelsLabel: UILabel!
    @IBOutlet weak var windLAbel: UILabel!
    
    var weatherData: [WeatherData]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getweather(from: "https://api.openweathermap.org/data/2.5/onecall?lat=50.265108&lon=57.205390&exclude=minutely,alerts,hourly&units=metric&lang=ru&appid=4ef2e9edd95153ca4989b50f0fafc65f")
//        getWeather()
    }
    
    func getweather(from url: String) {
        NetworkManager.shared.fetchData(url) { result in
            switch result {
            case .success(let weathers):
                print(weathers)
                self.weatherData = weathers
            case .failure( let error):
                print(error)
            }
        }
    }
    
    func getWeather() {
        for wearher in weatherData {
            temp.text = "\(wearher.lon ?? 0)"
        }
    }
    
}
