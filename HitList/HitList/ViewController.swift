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
  
  var people = [NSManagedObject]()
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "\"The List\""
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    loadNames()
  }
  
  @IBAction func addName(sender: UIBarButtonItem) {
    var alert = UIAlertController(title: "New name", message: "Add a new name", preferredStyle: .Alert)
    
    let saveAction = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction!) -> Void in
      let textField = alert.textFields![0] as UITextField
      self.saveName(textField.text)
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
  
  private func saveName(name: String) {
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    let managedContext = appDelegate.managedObjectContext!
    
    let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
    let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
    
    person.setValue(name, forKey: "name")
    
    var error: NSError?
    if !managedContext.save(&error) {
      println("Could not save \(error!), \(error!.userInfo)")
    }
    
    people.append(person)
  }
  
  private func loadNames() {
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    let managedContext = appDelegate.managedObjectContext!
    
    let fetchRequest = NSFetchRequest(entityName: "Person")
    
    var error: NSError?
    
    let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
    
    if fetchedResults != nil {
      people = fetchedResults!
    }
    else {
      println("Could not fetch \(error!), \(error!.userInfo)")
    }
  }
  
}

extension ViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return people.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
    
    cell.textLabel!.text = people[indexPath.row].valueForKey("name") as? String
    
    return cell
  }
  
}
