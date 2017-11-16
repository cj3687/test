//
//  City.swift
//  OpenWeather
//
//  Created by Mikhail Rostov on 28.06.17.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import Foundation
import CoreLocation

private struct CityDictionaryKeys {
    static let ID = "id"
    static let Name = "name"
    static let Country = "country"
    static let Coordinate = "coord"
    static let Latitude = "lat"
    static let Longitude = "lon"
}

enum CityError: Error {
    case invalidData
}

struct City {
    var id : Int?
    var name : String?
    var country : String?
    var location : CLLocationCoordinate2D?
    
    init(withDictionary jsonData : Dictionary<String, Any>) throws {
        if let id = jsonData[CityDictionaryKeys.ID] as? Int {
            self.id = id
        }
        
        if let name = jsonData[CityDictionaryKeys.Name] as? String {
            self.name = name
        }
        
        if let country = jsonData[CityDictionaryKeys.Country] as? String {
            self.country = country
        }
        
        if let coordinate = jsonData[CityDictionaryKeys.Coordinate] as? Dictionary <String,Any> {
            if let latitide = coordinate[CityDictionaryKeys.Latitude] as? Double,
                let longitude = coordinate[CityDictionaryKeys.Latitude] as? Double {
                self.location = CLLocationCoordinate2D(latitude: latitide, longitude: longitude)
            }
        }
        
        guard id != nil, name != nil, country != nil else {
            throw CityError.invalidData
        }
        
    }
}
