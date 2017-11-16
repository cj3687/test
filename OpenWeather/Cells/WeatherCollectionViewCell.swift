//
//  WeatherCollectionViewCell.swift
//  OpenWeather
//
//  Created by Mikhail Rostov on 28.06.17.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import UIKit

var tagCounter = 0

class WeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet var timeLabel : UILabel!
    @IBOutlet var temperatureLabel : UILabel!
    @IBOutlet var weatherImage : UIImageView!
    
    var networkController : WeatherAPIRequests?
    
    override func awakeFromNib() {
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.borderWidth = 0.5
    }
    
    var forecast : Forecast? {
        didSet {
            display()
        }
    }
    
    override func prepareForReuse() {
        _ = uniqueTag()
    }
    
    func uniqueTag() -> Int { // a simple way to deal with async cell re-use, a better way would be an operationQueue
        tagCounter += 1 // ++tagCounter no longer available in swift 3
        tag = tagCounter < Int.max ? tagCounter : 0
        return tag
    }
}

extension WeatherCollectionViewCell { // Presentation
    struct Shared {
        static var timeFormatter : DateFormatter = {
            var formatter = DateFormatter() // re-use this for scrolling performance
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            return formatter
        }()
        
        static var numberFormatter : NumberFormatter = {
            var formatter = NumberFormatter() // re-use this for scrolling performance
            formatter.maximumFractionDigits = 0
            return formatter
        }()
    }
    
    func formatTemperature(kelvin temperature : Double) -> String {
        let ZeroCKelvin = 273.15
        let temperatureString = Shared.numberFormatter.string(from: NSNumber(value: temperature - ZeroCKelvin));
        if let temperatureString = temperatureString {
            return "\(temperatureString)\u{2103}"
        } else {
            return "?"
        }
        
    }
        
    func display() {
        if let forecast = forecast, let timeStamp = forecast.timeStamp, let temperatureK = forecast.temperatureK {
            timeLabel.text = Shared.timeFormatter.string(from: timeStamp)
            temperatureLabel.text = formatTemperature(kelvin: temperatureK)
            
            if let iconName = forecast.iconName,
                let iconURL = URL(string: "http://openweathermap.org/img/w/\(iconName).png"),
                let networkController = networkController {
                let savedTag = uniqueTag()
                networkController.download(image: iconURL, completion: { [weak self] (image) in
                    guard let `self` = self else { return }
                    guard savedTag == self.tag else { return }
                    self.weatherImage.image = image
                })
            }
        }
    }
}

