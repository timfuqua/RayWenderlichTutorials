//
//  TableViewCell.swift
//  ClearStyle
//
//  Created by Tim Fuqua on 2/9/15.
//  Copyright (c) 2015 FuquaProductions. All rights reserved.
//

import UIKit
import QuartzCore

class TableViewCell: UITableViewCell {

  let gradientLayer = CAGradientLayer()
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    initializeGradientLayer()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    initializeGradientLayerFrame()
  }
  
  private func initializeGradientLayerFrame() {
    gradientLayer.frame = bounds
  }
  
  private func initializeGradientLayer() {
    initializeGradientLayerFrame()
    
    let color1 = UIColor(white: 1.0, alpha: 0.2).CGColor as CGColorRef
    let color2 = UIColor(white: 1.0, alpha: 0.1).CGColor as CGColorRef
    let color3 = UIColor.clearColor().CGColor as CGColorRef
    let color4 = UIColor(white: 0.0, alpha: 0.1).CGColor as CGColorRef
    
    gradientLayer.colors = [color1, color2, color3, color4]
    gradientLayer.locations = [0.0, 0.01, 0.95, 1.0]
    layer.insertSublayer(gradientLayer, atIndex: 0)
  }

}
