//
//  DailyTBVC.swift
//  WeatherApp
//
//  Created by Kuat Bodikov on 17.01.2022.
//

import UIKit

class DailyTBVC: UITableViewController {
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mainWeatherLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var nightLabel: UILabel!
    
    var cities: Cities!
    private var weathers: [Weather] = []
    private var dailyWeather: [Daily] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let day = dailyWeather[indexPath.row]
        mainWeatherLabel.text = day.temp.mainTemp
        feelsLikeLabel.text = day.feelsLike.feelDay
        dayLabel.text = day.temp.dayTemp
        nightLabel.text = day.temp.nightTemp
        let weathersOfDay = day.weather ?? []
        fetchImage(from: weathersOfDay)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dailyWeather.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dailyCell", for: indexPath) as! DailyTVCell
        let dailyWeather = dailyWeather[indexPath.row]
        cell.configure(from: dailyWeather)
        
        return cell
    }
    
    
    private func fetchData() {
        guard let city = cities else { return }
        
        NetworkManager.shared.fetch(dataType: WeatherData.self, from: city.cityUrl, convertFromSnakeCase: true) { result in
            switch result {
            case .success(let weather):
                self.setupWeather(from: weather)
                self.dailyWeather = weather.daily ?? []
                
                self.fetchImage(from: weather.current?.weather ?? [])
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }

    }
}

extension DailyTBVC {
    private func setupWeather(from weather: WeatherData) {
        mainWeatherLabel.text = weather.current?.temperture
        feelsLikeLabel.text = weather.current?.feels
        
    }
    
    private func fetchImage(from weather: [Weather]) {
        for weath in weather {
            self.descriptionLabel.text = weath.weatherDescription
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
    
}
