//
//  Inspiration.swift
//  RWDevCon
//
//  Created by Mic Pringle on 02/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class Weather: Session {
  
  class func allWeather() -> [Weather] {

    var weathers = [Weather]()
    let db = SQLiteDB.shared
    db.openDB()
    //let delete = db.execute(sql:"DELETE FROM city WHERE id > 8")
     var data = db.query(sql: "SELECT * FROM city")
     if data != nil{
        for i in 0 ... (data.count - 1) {
            
            let weather = Weather(dictionary: data[i] as! NSDictionary)
            weathers.append(weather)
            
        }
        
    }
    
    /*if let URL = Bundle.main.url(forResource: "City", withExtension: "plist") {
      if let tutorialsFromPlist = NSArray(contentsOf: URL) {
        for dictionary in tutorialsFromPlist {
          let weather = Weather(dictionary: dictionary as! NSDictionary)
          weathers.append(weather)
        }
      }
    }*/
    return weathers
  }
  
}


//---------------*-----------

