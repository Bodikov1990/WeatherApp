//
//  CurrentCollectionVC.swift
//  WeatherApp
//
//  Created by Kuat Bodikov on 17.01.2022.
//

import UIKit


class CurrentCollectionVC: UICollectionViewController {
    
    private var allCities = CityWeather.getCity()
    private var cityUrl: String!
    private var weatherData: [WeatherData]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allCities.cities.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "currentCell", for: indexPath) as! CurrentCell
        let city = allCities.cities[indexPath.item]
        cell.configure(from: city)
//        self.collectionView.reloadData()
        
        
        return cell
    }
}

extension CurrentCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 20, height: 100)
    }
}

extension CurrentCollectionVC {
    func fetchDataWithAlomafire(_ url: String) {
        NetworkManager.shared.fetchData(url) { result in
            switch result {
            case .success( let weathers):
                self.weatherData = weathers
                self.collectionView.reloadData()
            case .failure( let error):
                print(error)
            }
        }
    }
}
