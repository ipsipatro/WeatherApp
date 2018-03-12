//
//  Weather.swift
//  WeatherApp
//
//  Created by Ipsi Patro on 10/03/2018.
//  Copyright © 2018 Ipsi Patro. All rights reserved.
//

import UIKit

class Weather: NSObject, NSCoding {
    
    //MARK: Properties
    
    var cityName: String
    var weatherCondition: String?
    var iconImageURL: String?
    var temperature: Int?
    var windSpeedAndDirection: String?
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("cityNames")
    
    //MARK: Types
    
    struct PropertyKey {
        static let cityName = "cityName"
    }
    
    //MARK: Initialization
    
    init?(cityName: String, iconURL: String?, temperature: Int?, weatherCondition: String?, windSpeedAndDirection: String?) {
        
        // The city name must not be empty
        guard !cityName.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.cityName = cityName
        self.weatherCondition = weatherCondition
        self.temperature = temperature
        self.iconImageURL = iconURL
        self.windSpeedAndDirection = windSpeedAndDirection
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(cityName, forKey: PropertyKey.cityName)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.cityName) as? String else {
            return nil
        }
        
        self.init(cityName: name, iconURL: nil, temperature: nil, weatherCondition: nil, windSpeedAndDirection: nil)
        
    }
}
