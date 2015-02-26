//
//  ViewController.swift
//  TopApps
//
//  Created by Dani Arnaout on 9/1/14.
//  Edited by Eric Cerney on 9/27/14.
//  Copyright (c) 2014 Ray Wenderlich All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    DataManager.getTopAppsDataFromFileWithSuccess { (data) -> Void in
      
      var parseError: NSError?
      let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data,
        options: NSJSONReadingOptions.AllowFragments,
        error: &parseError)
      
      if let topApps = parsedObject as? NSDictionary {
        if let feed = topApps["feed"] as? NSDictionary {
          if let apps = feed["entry"] as? NSArray {
            if let firstApp = apps[0] as? NSDictionary {
              if let imname = firstApp["im:name"] as? NSDictionary {
                if let appName = imname["label"] as? NSString {
                  println("Optional Binding: \(appName)")
                }
              }
            }
          }
        }
      }
    }
  }
}

