//
//  FavouriteCitiesTableViewCell.swift
//  WeatherApp
//
//  Created by Ipsi Patro on 11/03/2018.
//  Copyright © 2018 Ipsi Patro. All rights reserved.
//

import UIKit

class FavouriteCitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    
    //MARK: Properties
    var weather: Weather? {
        didSet {
            guard let weather = weather else{
                return
            }
            cityNameLabel.text = weather.cityName
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
