//
//  InspirationsViewController.swift
//  RWDevCon
//
//  Created by Mic Pringle on 02/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class WeatherViewController: UICollectionViewController {
    
    
    let weathers = Weather.allWeather()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let patternImage = UIImage(named: "Pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addAction))
        navigationItem.rightBarButtonItem = button
        title = NSLocalizedString("Open Weather", comment: "VC title")
        collectionView!.backgroundColor = UIColor.clear
        collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
        if #available(iOS 10.0, *) {
            collectionView?.isPrefetchingEnabled = false
        }
    }
    
}


extension WeatherViewController {
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func addAction(){
        
        let storyboard = UIStoryboard(name: "SearchCity", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "searchCityController") as UIViewController
        present(vc, animated: true, completion: nil)
        print("add city")
    }
    
    func tapFunction(sender: UIGestureRecognizer) {
        //   Weather.allWeather()
        print (self.weathers[(sender.view?.tag)!].title)
        
        let currentCityName = self.weathers[(sender.view?.tag)!].title.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        if currentCityName != nil {
            UserDefaults.standard.set(currentCityName, forKey: "currentCityName")
        }
        else{
            UserDefaults.standard.set(self.weathers[(sender.view?.tag)!].title, forKey: "currentCityName")
        }
        let storyboard = UIStoryboard(name: "WeatherDetail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "navigationController") as UIViewController
        present(vc, animated: true, completion: nil)
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        cell.tag = indexPath.row
        print("indexPath.row = ", indexPath.row)
        let tap = UITapGestureRecognizer(target: self, action: #selector(WeatherViewController.tapFunction))
        cell.isUserInteractionEnabled = true
        cell.addGestureRecognizer(tap)
        cell.weather = weathers[indexPath.item]
        
        return cell
        
    }
    
    
}
