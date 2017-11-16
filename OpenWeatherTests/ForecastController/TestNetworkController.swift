//
//  TestNetworkController.swift
//  OpenWeather
//
//  Created by Mikhail Rostov on 28.06.17.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import XCTest
@testable import OpenWeather

class TestNetworkController : WeatherAPIRequests {
    func getForecast(completion: @escaping (WeatherAPIResult) -> Void ) {
        do {
            let data = try Data(contentsOf: Bundle.main.url(forResource: "forecast", withExtension: "json")!, options: [])
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            completion(.success(jsonObject as! Dictionary<String,Any>))
        } catch let error {
            completion(.error(error))
        }
        
    }
    
    func download(image fromUrl : URL, completion: @escaping (UIImage?) -> Void) {
        completion(nil)
    }
    
}
