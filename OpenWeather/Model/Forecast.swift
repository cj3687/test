//
//  Forecast.swift
//  OpenWeather
//
//  Created by Mikhail Rostov on 28.06.17.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import Foundation

private struct ForecastDictionaryKeys {
    static let TimeStamp = "dt"
    static let Main = "main"
    static let Temp = "temp"
    static let Weather = "weather"
    static let Icon = "icon"
}

enum ForecastError: Error {
    case invalidData
}

struct Forecast {
    var timeStamp : Date?
    var temperatureK : Double?
    var iconName : String?
    
    init(withDictionary jsonData : Dictionary<String, Any>) throws {
        if let timeStamp = jsonData[ForecastDictionaryKeys.TimeStamp] as? Double {
            self.timeStamp = Date(timeIntervalSince1970: timeStamp)
        }
        
        if let main = jsonData[ForecastDictionaryKeys.Main] as? Dictionary <String,Any> {
            if let temp = main[ForecastDictionaryKeys.Temp] as? Double {
                self.temperatureK = temp
            }
        }
        
        if let weather = jsonData[ForecastDictionaryKeys.Weather] as? [Dictionary <String,Any>] {
            for each in weather {
                if let icon = each[ForecastDictionaryKeys.Icon] as? String {
                    self.iconName = icon
                }
            }

        }
        
        guard timeStamp != nil, temperatureK != nil, iconName != nil else {
            throw ForecastError.invalidData
        }
        
    }
}

extension Forecast { // grouping key
    struct Shared {
        static var timeFormatter : DateFormatter = {
            var formatter = DateFormatter() // re-use this for performance
            formatter.dateFormat = "yyyy_MM_dd"
            return formatter
        }()
    }
    
    var groupingKey : String {
        if let timeStamp = timeStamp {
            return Shared.timeFormatter.string(from: timeStamp)
        } else {
            return ""
        }
    }
}

extension Forecast : CustomStringConvertible {
    var description: String {
        return "\(type(of: self)) \(timeStamp) \(temperatureK)"
    }
}
