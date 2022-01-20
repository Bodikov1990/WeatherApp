//
//  CurrentCell.swift
//  WeatherApp
//
//  Created by Kuat Bodikov on 17.01.2022.
//

import UIKit

class CurrentCell: UICollectionViewCell {
    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var feelsLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    private var weatherData: [WeatherData] = []
    private var weathers: WeatherData!
    private var temperture: Double!
    
    
    func configure(from city: Cities) {
        cityLabel.text = city.cityName
        print("\(city.cityUrl)")
        NetworkManager.shared.fetchData(city.cityUrl) { result in

            switch result {
            case .success(let weathers):
                self.weatherData = weathers
            case .failure( let error):
                print(error)
            }
        }
    }
}
