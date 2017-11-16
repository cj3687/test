//
//  WeatherCollectionViewCellTests.swift
//  OpenWeather
//
//  Created by Mikhail Rostov on 28.06.17.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import XCTest
@testable import OpenWeather

class WeatherCollectionViewCellTests: XCTestCase {
    
    func testTemperatureFormatting() {
        let cell = WeatherCollectionViewCell()
        XCTAssertTrue(cell.formatTemperature(kelvin: 200) == "-73\u{2103}", cell.formatTemperature(kelvin: 200))
        XCTAssertTrue(cell.formatTemperature(kelvin: 0) == "-273\u{2103}", cell.formatTemperature(kelvin: 0))
        XCTAssertTrue(cell.formatTemperature(kelvin: 500) == "227\u{2103}", cell.formatTemperature(kelvin: 500))
    }
    
}
