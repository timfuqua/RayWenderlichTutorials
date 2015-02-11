//
//  TableViewCell.swift
//  ClearStyle
//
//  Created by Tim Fuqua on 2/9/15.
//  Copyright (c) 2015 FuquaProductions. All rights reserved.
//

import UIKit
import QuartzCore

protocol TableViewCellDelegate {
  func toDoItemDeleted(todoItem: ToDoItem)
}

class TableViewCell: UITableViewCell {

  let gradientLayer = CAGradientLayer()

  var originalCenter = CGPoint()
  var deleteOnDragRelease = false
  var completeOnDragRelease = false
  
  let label: StrikeThroughText
  let itemCompleteLayer = CALayer()
  
  var delegate: TableViewCellDelegate?
  var toDoItem: ToDoItem? {
    didSet {
      label.text = toDoItem!.text
      label.shouldStrikeThrough = toDoItem!.completed
      itemCompleteLayer.hidden = !label.shouldStrikeThrough
    }
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("NSCoding not supported")
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    label = StrikeThroughText(frame: CGRect.nullRect)
    label.textColor = UIColor.whiteColor()
    label.font = UIFont.boldSystemFontOfSize(16)
    label.backgroundColor = UIColor.clearColor()
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(label)
    selectionStyle = .None
    
    initializeGradientLayer()
    
    itemCompleteLayer = CALayer(layer: layer)
    itemCompleteLayer.backgroundColor = UIColor(red: 0.0, green: 0.6, blue: 0.0, alpha: 1.0).CGColor
    itemCompleteLayer.hidden = true
    layer.insertSublayer(itemCompleteLayer, atIndex: 0)
    
    initializePanGestureRecognizer()
  }
  
  let kLabelLeftMargin: CGFloat = 15.0
  override func layoutSubviews() {
    super.layoutSubviews()
    initializeGradientLayerFrame()
    itemCompleteLayer.frame = bounds
    label.frame = CGRect(x: kLabelLeftMargin, y: 0, width: bounds.size.width - kLabelLeftMargin, height: bounds.size.height)
  }
  
  private func initializeItemCompleteLayer() {
//    itemCompleteLayer = CALayer(layer: layer)
    itemCompleteLayer.backgroundColor = UIColor(red: 0.0, green: 0.6, blue: 0.0, alpha: 1.0).CGColor
    itemCompleteLayer.hidden = true
    layer.insertSublayer(itemCompleteLayer, atIndex: 0)
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
  
  private func initializePanGestureRecognizer() {
    var recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
    recognizer.delegate = self
    addGestureRecognizer(recognizer)
  }

  func handlePan(recognizer: UIPanGestureRecognizer) {
    if recognizer.state == .Began {
      originalCenter = center
    }
    
    if recognizer.state == .Changed {
      let translation = recognizer.translationInView(self)
      center = CGPointMake(originalCenter.x + translation.x, originalCenter.y)
      deleteOnDragRelease = frame.origin.x < -frame.size.width / 2.0
      completeOnDragRelease = frame.origin.x > -frame.size.width / 2.0
    }
    
    if recognizer.state == .Ended {
      let originalFrame = CGRect(x: 0, y: frame.origin.y, width: bounds.size.width, height: bounds.size.height)

      if deleteOnDragRelease {
        if delegate != nil && toDoItem != nil {
          delegate!.toDoItemDeleted(toDoItem!)
        }
      }
      else if completeOnDragRelease {
        if toDoItem != nil {
          toDoItem!.completed = true
        }
        label.shouldStrikeThrough = true
        itemCompleteLayer.hidden = false
        UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
      }
      else {
        UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
      }
    }
  }
  
  override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
    if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
      let translation = panGestureRecognizer.translationInView(superview!)
      if fabs(translation.x) > fabs(translation.y) {
        return true
      }
      return false
    }
    return false
  }
}
