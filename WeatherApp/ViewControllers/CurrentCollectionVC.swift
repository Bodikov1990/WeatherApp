//
//  CurrentCollectionVC.swift
//  WeatherApp
//
//  Created by Kuat Bodikov on 17.01.2022.
//

import UIKit


class CurrentCollectionVC: UICollectionViewController {
    
    private var allCities = CityWeather.getCity()
    private var weatherData: WeatherData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cities = allCities.cities[indexPath.item]
        performSegue(withIdentifier: "showTableView", sender: cities)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dailyTBVC = segue.destination as? DailyTBVC else { return }
        dailyTBVC.cities = sender as? Cities
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allCities.cities.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "currentCell", for: indexPath) as! CurrentCell
        let city = allCities.cities[indexPath.item]
        cell.configure(from: city)
        title = "Погода на сегодня"
        
        return cell
    }
}

extension CurrentCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 20, height: 100)
    }
}
