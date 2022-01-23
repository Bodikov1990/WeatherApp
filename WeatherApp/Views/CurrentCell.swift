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
    @IBOutlet weak var descriptionLanel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var currentCityTimeLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    private var weathers: [Weather] = []
    
    func configure(from city: Cities) {
        cityLabel.text = city.cityName
        NetworkManager.shared.fetch(dataType: WeatherData.self, from: city.cityUrl, convertFromSnakeCase: true) { result in
            switch result {
                
            case .success(let weather):
                
                self.currentTempLabel.text = weather.current?.temperture
                self.feelsLabel.text = weather.current?.feels
                self.windSpeedLabel.text = weather.current?.wind
                self.weathers = weather.current?.weather ?? []
                
                self.getDate(for: weather.current?.dt ?? 0, for: weather.timezoneOffset ?? 0)
                
                self.fetchImage(from: self.weathers)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    private func fetchImage(from weather: [Weather]) {
        for weath in weather {
            self.descriptionLanel.text = weath.weatherDescription
            NetworkManager.shared.fetchImage(from: weath.conditionCode) { result in
                switch result {
                case .success(let image):
                    self.currentImage.image = UIImage(data: image)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getDate(for epochTime: Int, for timezoneOfset: Int){
        let currentEpochtime = epochTime
        let date = NSDate(timeIntervalSince1970: TimeInterval(currentEpochtime))
        let formatter = DateFormatter()
        formatter.timeZone = .init(secondsFromGMT: timezoneOfset)
        formatter.dateFormat = "E. HH:mm"
        let currentDate = formatter.string(from: date as Date)
        currentCityTimeLabel.text = currentDate
    }
    
}
