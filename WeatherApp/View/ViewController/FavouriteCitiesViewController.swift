//
//  FavouriteCitiesViewController.swift
//  WeatherApp
//
//  Created by Ipsi Patro on 11/03/2018.
//  Copyright © 2018 Ipsi Patro. All rights reserved.
//

import UIKit

class FavouriteCitiesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    //MARK: Properties
    
    var weatherList = [Weather]()
    var selectedCityName: String?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if let weatherList = WeatherDataManager.getSavedWeatherList() {
            self.weatherList = weatherList
        }
    }
   
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityTableViewCell", for: indexPath) as! FavouriteCitiesTableViewCell
        let weather = weatherList[indexPath.row]
        cell.weather = weather
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableView.separatorColor = UIColor.lightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.weatherList.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            WeatherDataManager.saveWeathers(self.weatherList)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndex = tableview.indexPathForSelectedRow?.row {
            let selectedWeather = weatherList[selectedIndex]
            self.selectedCityName = selectedWeather.cityName

        }
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
}
