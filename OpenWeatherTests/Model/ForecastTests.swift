//
//  ForecastTests.swift
//  OpenWeather
//
//  Created by Mikhail Rostov on 28.06.17.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import XCTest
@testable import OpenWeather

class ForecastTests: XCTestCase {
    
    static let TimeStamp = "dt"
    static let Main = "main"
    static let Temp = "temp"
    static let Weather = "weather"
    static let Icon = "icon"
    
    func testForecast() {
        let jsonDictionary : Dictionary <String,Any> = [
            "dt" : 11241244.0,
            "main" : [
                "temp" : 15.0,
                "other" : 9
            ],
            "weather" : [[
                "icon" : "testicon",
                "other" : 9
            ]]
        ]
        
        do {
            let forecast = try Forecast(withDictionary: jsonDictionary);
            
            XCTAssert(forecast.iconName == "testicon", "\(forecast.iconName)")
            XCTAssert(forecast.temperatureK == 15.0, "\(forecast.temperatureK)")
            XCTAssertNotNil(forecast.timeStamp)
            
        } catch {
            XCTFail("threw")
        }
        
    }
    
}
