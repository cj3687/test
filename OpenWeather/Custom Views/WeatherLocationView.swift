//
//  WeatherLocationView.swift
//  OpenWeather
//
//  Created by Mikhail Rostov on 28.06.17.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import UIKit

class WeatherLocationView: UIView {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var countryLabel : UILabel!
    
    var city :  City? {
        didSet {
            display()
        }
    }

}

extension WeatherLocationView { // presentation
    
    func display() {
        if let city = city,
            
        
            let name = city.name,
            let country = city.country {
            nameLabel.text = name
            countryLabel.text = country
        }
    }
}
