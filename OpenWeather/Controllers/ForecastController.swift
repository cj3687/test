//
//  ForecastController.swift
//  OpenWeather
//
//  Created by Mikhail Rostov on 28.06.17.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//
//  Populates the model from JSON

import Foundation

class ForecastController {
    
    var networkController : WeatherAPIRequests
    
    init(networkController _networkController: WeatherAPIRequests) {
        networkController = _networkController
    }
    
    func getForecast(completionHandler: @escaping (ForecastWeek?, Error?) -> ()) {
        networkController.getForecast(completion: { (result) in
            switch result {
            case let .success(jsonDictionary):
                do {
                    let week = try ForecastWeek(withDictionary: jsonDictionary)
                    DispatchQueue.main.async {
                        completionHandler(week,nil)
                    }
                } catch let error {
                    completionHandler(nil,error)
                }
            case let .error(error):
                completionHandler(nil,error)
            }
        })
    }
}
