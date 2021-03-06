//
//  TutorialCell.swift
//  RWDevCon
//
//  Created by Mic Pringle on 27/02/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
  

  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var imageCoverView: UIView!
  @IBOutlet private weak var titleLabel: UILabel!
 // @IBOutlet private weak var timeAndRoomLabel: UILabel!
  @IBOutlet private weak var speakerLabel: UILabel!
  
  var weather: Weather? {
    didSet {
      if let weather = weather {
        imageView.image = weather.backgroundImage
        titleLabel.text = weather.title
        //timeAndRoomLabel.text = inspiration.roomAndTime
        speakerLabel.text = weather.speaker
      }
    }
  }
  
  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
    
    let featuredHeight = UltravisualLayoutConstants.Cell.featuredHeight
    let standardHeight = UltravisualLayoutConstants.Cell.standardHeight
        
    let delta = 1 - ((featuredHeight - frame.height) / (featuredHeight - standardHeight))
    
    let minAlpha: CGFloat = 0.3
    let maxAlpha: CGFloat = 0.75
    
    imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
    
    let scale = max(delta, 0.5)
    titleLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
    
    //timeAndRoomLabel.alpha = delta
    speakerLabel.alpha = delta
  }
    
    
  
}
