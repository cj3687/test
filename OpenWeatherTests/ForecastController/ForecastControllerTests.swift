//
//  ForecastControllerTests.swift
//  OpenWeather
//
//  Created by Mikhail Rostov on 28.06.17.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import XCTest
@testable import OpenWeather

class ForecastControllerTests: XCTestCase {
    
    var forecastController : ForecastController?
    
    override func setUp() {
        forecastController = ForecastController(networkController: TestNetworkController())
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetForecast() {
        if let forecastController = forecastController {
            forecastController.getForecast() { (forecastweek, error) in
                XCTAssertNil(error)
                XCTAssertNotNil(forecastweek)
                if let forecastweek = forecastweek {
                    XCTAssertNotNil(forecastweek.city)
                    XCTAssert(forecastweek.days.count == 6, "\(forecastweek.days.count)")
                }
            }
        }

    }
    
}
