//
//  DailyTBVC.swift
//  WeatherApp
//
//  Created by Kuat Bodikov on 17.01.2022.
//

import UIKit

class DailyTBVC: UITableViewController {

    var cities: Cities!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dailyCell", for: indexPath) as! DailyTVCell

        // Configure the cell...

        return cell
    }
}
