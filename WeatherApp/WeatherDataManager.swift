//
//  WeatherDataManager.swift
//  WeatherApp
//
//  Created by Ipsi Patro on 11/03/2018.
//  Copyright © 2018 Ipsi Patro. All rights reserved.
//

import UIKit

class WeatherDataManager: NSObject {

    static func getSavedWeatherList() -> [Weather]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Weather.ArchiveURL.path) as? [Weather]
    }
    
    static func saveWeathers(_ weathers: [Weather]) {
        NSKeyedArchiver.archiveRootObject(weathers, toFile: Weather.ArchiveURL.path)
    }

}
