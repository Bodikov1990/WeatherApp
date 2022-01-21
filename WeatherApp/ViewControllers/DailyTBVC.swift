//
//  DailyTBVC.swift
//  WeatherApp
//
//  Created by Kuat Bodikov on 17.01.2022.
//

import UIKit

class DailyTBVC: UITableViewController {
    
    var cities: Cities!
    private var dailyWeather: [Daily] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    // MARK: - Table view data source
    
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
                print(weather)
                self.dailyWeather = weather.daily ?? []
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
