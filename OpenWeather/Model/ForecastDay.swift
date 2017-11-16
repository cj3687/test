//
//  ForecastDay.swift
//  OpenWeather
//
//  Created by Mikhail Rostov on 28.06.17.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import Foundation

class ForecastDay { // class because items is mutable
    var timeStamp : Date?
    var items : [Forecast] = []
}
