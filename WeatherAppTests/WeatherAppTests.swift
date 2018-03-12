//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Ipsi Patro on 10/03/2018.
//  Copyright © 2018 Ipsi Patro. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {
    
    func testRatingInitialisationSuccess() {
        
        let noCityNameWeather = Weather.init(cityName: "", iconURL: nil, temperature: 10, weatherCondition: "rain", windSpeedAndDirection: "S")
        XCTAssertNil(noCityNameWeather)
        
        let validCityNameWeather = Weather.init(cityName: "Bournemouth", iconURL: nil, temperature: 10, weatherCondition: nil, windSpeedAndDirection: nil)
        XCTAssertNotNil(validCityNameWeather)
        
    }
}
