//
//  ViewController.swift
//  ClearStyle
//
//  Created by Tim Fuqua on 2/9/15.
//  Copyright (c) 2015 FuquaProductions. All rights reserved.
//
// http://www.raywenderlich.com/77974/making-a-gesture-driven-to-do-list-app-like-clear-in-swift-part-1
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var toDoItems = [ToDoItem]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initializeTableView()
    initializeTableStyling()
    initializeToDoList()
  }
  
  private func initializeTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  private func initializeTableStyling() {
    tableView.separatorStyle = .None
    tableView.backgroundColor = UIColor.blackColor()
    tableView.rowHeight = 50.0
  }
  
  private func initializeToDoList() {
    if toDoItems.count > 0 {
      return
    }
    
    toDoItems.append(ToDoItem(text: "feed the cat"))
    toDoItems.append(ToDoItem(text: "buy eggs"))
    toDoItems.append(ToDoItem(text: "watch WWDC videos"))
    toDoItems.append(ToDoItem(text: "rule the Web"))
    toDoItems.append(ToDoItem(text: "buy a new iPhone"))
    toDoItems.append(ToDoItem(text: "darn holes in socks"))
    toDoItems.append(ToDoItem(text: "write this tutorial"))
    toDoItems.append(ToDoItem(text: "master Swift"))
    toDoItems.append(ToDoItem(text: "learn to draw"))
    toDoItems.append(ToDoItem(text: "get more exercise"))
    toDoItems.append(ToDoItem(text: "catch up with Mom"))
    toDoItems.append(ToDoItem(text: "get a hair cut"))
  }

  private func colorForIndex(index: Int) -> UIColor {
    let itemCount = toDoItems.count - 1
    let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
    return UIColor(red: 1.0, green: val, blue: 0.0, alpha: 1.0)
  }
  
}

extension ViewController: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return toDoItems.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as TableViewCell
    cell.selectionStyle = UITableViewCellSelectionStyle.None
    cell.textLabel?.backgroundColor = UIColor.clearColor()
    
    let item = toDoItems[indexPath.row]
    cell.textLabel?.text = item.text
    
    return cell
  }
  
}

extension ViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
    forRowAtIndexPath indexPath: NSIndexPath) {
      cell.backgroundColor = colorForIndex(indexPath.row)
  }
  
}
