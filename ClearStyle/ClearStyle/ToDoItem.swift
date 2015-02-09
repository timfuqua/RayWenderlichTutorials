//
//  ToDoItem.swift
//  ClearStyle
//
//  Created by Tim Fuqua on 2/9/15.
//  Copyright (c) 2015 FuquaProductions. All rights reserved.
//

import UIKit

class ToDoItem: NSObject {
  var text: String
  var completed: Bool

  init(text: String) {
    self.text = text
    self.completed = false
  }
}
