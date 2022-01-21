//
//  DailyTVCell.swift
//  WeatherApp
//
//  Created by Kuat Bodikov on 17.01.2022.
//

import UIKit

class DailyTVCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dailyWeatherLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    private var dates: String!
    private var weathers: [Weather] = []
    
    
    func configure(from day: Daily) {
        getDate(for: day.dt ?? 0)
        dateLabel.text = dates
        dailyWeatherLabel.text = day.temp.dayAndNight
        weathers = day.weather ?? []
        
        for weath in self.weathers {
            NetworkManager.shared.fetchImage(from: weath.conditionCode) { result in
                switch result {
                case .success(let image):
                    self.weatherImage.image = UIImage(data: image)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getDate(for epochTime: Int){
        let currentEpochtime = epochTime
        let date = NSDate(timeIntervalSince1970: TimeInterval(currentEpochtime))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        dates = formatter.string(from: date as Date)
    }
}
