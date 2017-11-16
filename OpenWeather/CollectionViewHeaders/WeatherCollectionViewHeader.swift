//
//  WeatherCollectionViewHeader.swift
//  OpenWeather
//
//  Created by Mikhail Rostov on 28.06.17.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import UIKit

class WeatherCollectionViewHeader: UICollectionReusableView {
    @IBOutlet var headingLabel : UILabel!
    
    var forecastday : ForecastDay? {
        didSet {
            display()
        }
    }
}

extension WeatherCollectionViewHeader { // Presentation
    struct Shared {
        static var timeFormatter : DateFormatter = {
            var formatter = DateFormatter() // re-use this for scrolling performance
            formatter.dateStyle = .full
            formatter.timeStyle = .none
            return formatter
        }()
    }
    
    func display() {
        if let timeStamp = forecastday?.timeStamp {
            headingLabel.text = Shared.timeFormatter.string(from: timeStamp)
        }
    }
}

