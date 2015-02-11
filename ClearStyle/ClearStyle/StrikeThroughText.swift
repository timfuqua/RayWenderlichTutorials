//
//  StrikeThroughText.swift
//  ClearStyle
//
//  Created by Tim Fuqua on 2/10/15.
//  Copyright (c) 2015 FuquaProductions. All rights reserved.
//

import UIKit
import QuartzCore

class StrikeThroughText: UILabel {
  
  lazy var strikeThroughLayer: CALayer = {
    let layer = CALayer()
    layer.backgroundColor = UIColor.whiteColor().CGColor
    layer.hidden = true
    return layer
  }()
  
  var shouldStrikeThrough: Bool = false {
    didSet {
      strikeThroughLayer.hidden = !shouldStrikeThrough
      if shouldStrikeThrough {
        resizeStrikeThrough()
      }
    }
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("NSCoding not supported")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    layer.addSublayer(strikeThroughLayer)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    resizeStrikeThrough()
  }
  
  let kStrikeThroughThickness: CGFloat = 2.0
  private func resizeStrikeThrough() {
    let textSize = text!.sizeWithAttributes([NSFontAttributeName: font])
    strikeThroughLayer.frame = CGRect(x: 0, y: bounds.size.height/2, width: textSize.width, height: kStrikeThroughThickness)
  }

}
