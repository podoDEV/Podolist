//
//  CAGradientLayer+Additions.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

public extension CAGradientLayer {

  convenience init(frame: CGRect, colors: [UIColor]) {
    self.init()
    self.frame = frame
    self.colors = []
    for color in colors {
      self.colors?.append(color.cgColor)
    }
    startPoint = CGPoint(x: 0.5, y: 0)
    endPoint = CGPoint(x: 0.5, y: 1)
  }
  
  func createGradientImage() -> UIImage? {
    var image: UIImage?
    UIGraphicsBeginImageContext(bounds.size)
    if let context = UIGraphicsGetCurrentContext() {
      render(in: context)
      image = UIGraphicsGetImageFromCurrentImageContext()
    }
    UIGraphicsEndImageContext()
    return image
  }
}

extension UINavigationBar {
  
  func setGradientBackground(colors: [UIColor]) {
    var updatedFrame = bounds
    updatedFrame.size.height += self.frame.origin.y
    let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
    let gradientImage = gradientLayer.createGradientImage()
    
    if #available(iOS 11.0, *) {
      barTintColor = UIColor(patternImage: gradientImage!)
    } else {
      setBackgroundImage(gradientImage, for: .default)
    }
  }
}
