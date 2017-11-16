//
//  CityTests.swift
//  OpenWeather
//
//  Created by Mikhail Rostov on 28.06.17.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import XCTest
@testable import OpenWeather

class CityTests: XCTestCase {
    
    func testCity() {
        let jsonDictionary : Dictionary <String,Any> = [
            "id" : 1,
            "name" : "testName",
            "country" : "testCountry",
            "coord" : [
                "lat" : 50.0,
                "lon" : 51.0
            ]
        ]
        
        do {
            let city = try City(withDictionary: jsonDictionary);
            
            XCTAssert(city.id == 1, "\(city.id)")
            XCTAssert(city.name == "testName", city.name!)
            XCTAssert(city.country == "testCountry", city.country!)
            XCTAssertNotNil(city.location)
            
        } catch {
            XCTFail("threw")
        }

    }
    
    
}
