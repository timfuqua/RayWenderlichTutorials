//
//  ViewController.swift
//  HitList
//
//  Created by Tim Fuqua on 5/1/15.
//  Copyright (c) 2015 FuquaProductions. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
  
  var names = [String]()
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "\"The List\""
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
  }
  
  @IBAction func addName(sender: UIBarButtonItem) {
    var alert = UIAlertController(title: "New name", message: "Add a new name", preferredStyle: .Alert)
    
    let saveAction = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction!) -> Void in
      let textField = alert.textFields![0] as UITextField
      self.names.append(textField.text)
      self.tableView.reloadData()
    }
    
    let cancelAction = UIAlertAction(title: "Cancel",
      style: .Default) { (action: UIAlertAction!) -> Void in
    }
    
    alert.addTextFieldWithConfigurationHandler {
      (textField: UITextField!) -> Void in
    }
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    
    presentViewController(alert, animated: true, completion: nil)
  }
  
}

extension ViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return names.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
    
    cell.textLabel!.text = names[indexPath.row]
    
    return cell
  }
  
}
