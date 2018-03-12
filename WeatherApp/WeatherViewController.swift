//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Ipsi Patro on 10/03/2018.
//  Copyright © 2018 Ipsi Patro. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UISearchBarDelegate {

@IBOutlet weak var searchBar: UISearchBar!

@IBOutlet weak var cityNameLabel: UILabel!

@IBOutlet weak var weatherConditionLabel: UILabel!

@IBOutlet weak var temperatureLabel: UILabel!

@IBOutlet weak var iconImageView: UIImageView!
    
@IBOutlet weak var windSpeedAndDirectionLabel: UILabel!
    
@IBOutlet weak var windLabel: UILabel!
    
@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
    super.viewDidLoad()
        searchBar.delegate = self
        activityIndicator.hidesWhenStopped = true
        setHiddenPropertiesForViewsAs(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WeatherReportsOperationManager.sharedInstance.loadSerchedWeathers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        searchBar.text = ""
        setHiddenPropertiesForViewsAs(true)
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            activityIndicator.startAnimating()
            fetchWeatherReportFor(city: text)
        }
    }

    
    // MARK: - private methods
    
    private func fetchWeatherReportFor(city: String) {
        WeatherReportsOperationManager.sharedInstance.getWeatherReportForCity(city:"\(city.replacingOccurrences(of: " ", with: "%20"))", completion: {self.updateView()})
    }
    
    private func updateView() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.setHiddenPropertiesForViews()
            self.cityNameLabel.isHidden = false
            if let weather = WeatherReportsOperationManager.sharedInstance.weather {
                self.cityNameLabel.text = weather.cityName
                if let tempDesc = weather.temperature?.description {
                    self.temperatureLabel.text = tempDesc+"℃"
                }
                self.weatherConditionLabel.text = weather.weatherCondition
                
                if let iconURL = weather.iconImageURL {
                    if let url = URL(string: iconURL) {
                        let data = try? Data(contentsOf: url)
                        if let data = data {
                            self.iconImageView.image = UIImage(data: data)
                        }
                    }
                }
                
                if weather.windSpeedAndDirection != nil {
                    self.windSpeedAndDirectionLabel.text = weather.windSpeedAndDirection
                    self.windLabel.text = "Wind"
                }
            }else {
                self.cityNameLabel.text = "City not found"
            }
        }
    }
    
    private func setHiddenPropertiesForViews() {
         var noResultsFound = true
        if let _ = WeatherReportsOperationManager.sharedInstance.weather {
            noResultsFound = false
        }
        setHiddenPropertiesForViewsAs(noResultsFound)
    }
    
    private func setHiddenPropertiesForViewsAs(_ hiddenFlag: Bool) {
        self.temperatureLabel.isHidden = hiddenFlag
        self.weatherConditionLabel.isHidden = hiddenFlag
        self.iconImageView.isHidden = hiddenFlag
        self.windSpeedAndDirectionLabel.isHidden = hiddenFlag
        self.windLabel.isHidden = hiddenFlag
        self.cityNameLabel.isHidden = hiddenFlag
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindSegueFromCityListController(_ sender: UIStoryboardSegue) {
        if sender.source is FavouriteCitiesViewController {
            if let senderVC = sender.source as? FavouriteCitiesViewController, let cityName = senderVC.selectedCityName{
                fetchWeatherReportFor(city: cityName)
            }
        }
    }
}
