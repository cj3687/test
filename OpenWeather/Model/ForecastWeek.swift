//
//  ForecastWeek.swift
//  OpenWeather
//
//  Created by Mikhail Rostov on 28.06.17.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import Foundation

private struct APIDictionaryKey {
    static let Forecast = "list"
    static let City = "city"
}

enum ForecastWeekError: Error {
    case invalidData
}

class ForecastWeek {
    var days : [ForecastDay] = []
    var city : City?
    
    init() { // blank to start with
        
    }
    
    init(withDictionary jsonData : Dictionary<String, Any>) throws {
        if let jsonForecastArray = jsonData[APIDictionaryKey.Forecast] as? Array<Any> {
            let forecasts : [Forecast?] = jsonForecastArray.map({ (eachforecast) in
                if let forecastDictionary = eachforecast as? Dictionary<String,Any>,
                    let forecast = try? Forecast(withDictionary: forecastDictionary) {
                    return forecast
                } else {
                    assertionFailure("INVALID FORECAST DATA")
                    return nil
                }
            })
            
            let ungroupedforecasts = forecasts.flatMap{ $0 } // remove optionals
            
            self.days = group(forecasts: ungroupedforecasts)
            
        }
        
        if let cityDictionary = jsonData[APIDictionaryKey.City] as? Dictionary<String,Any> {
            city = try? City(withDictionary: cityDictionary)
        }
        
        guard city != nil, !days.isEmpty else {
            throw ForecastWeekError.invalidData
        }
    }
    
    private func group(forecasts : [Forecast]) -> [ForecastDay] {
        var groupedDays : Dictionary<String, ForecastDay> = [:]
        
        for forecast in forecasts {
            let key = forecast.groupingKey
            if let existingday = groupedDays[key] {
                existingday.items.append(forecast)
            } else {
                let newDay = ForecastDay()
                newDay.timeStamp = forecast.timeStamp
                newDay.items.append(forecast)
                groupedDays[key] = newDay
            }
        }
        
        return groupedDays.map { (_,value) in
            return value
        }.sorted(by: { (day1, day2) -> Bool in
            return day1.timeStamp!.compare(day2.timeStamp!) == .orderedAscending
        })
    }

}
