//
//  ViewController.swift
//  ToDoListDemo
//
//  Created by huangyibiao on 15/9/14.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import UIKit

/// 实战练习
///
/// - Note:
/// - Blog: http://www.hybblog.com/
/// - Email: huangyibiao520@163.com
/// - Github: https://github.com/632840804/
/// - 微博：JackyHuang标哥
/// - QQ群：324400294
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate {
  // MARK: Private Propertites
  private var dataSource = [EventItemModel]()
  private var tableView: UITableView!
  private var currentSelectedIndexPath: NSIndexPath?
  
  // MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "JackyHuang教你实战"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "添加",
      style: UIBarButtonItemStyle.Plain,
      target: self,
      action: "onAddItemHandler:")
    
    var item = EventItemModel()
    item.itemName = "加入QQ群：324400294"
    dataSource.append(item)
    
    item = EventItemModel()
    item.itemName = "Blog: http://www.hybblog.com/"
    item.isCompleted = true
    dataSource.append(item)
    
    tableView = UITableView(frame: self.view.bounds)
    tableView.delegate = self
    tableView.dataSource = self
    self.view.addSubview(tableView)
  }
  
  // MARK: UITableViewDataSource
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier = "cellIdentifier"
    var cell: EventItemCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? EventItemCell
    
    if cell == nil {
      cell = EventItemCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
    }
    
    if indexPath.row < dataSource.count {
      let model = dataSource[indexPath.row]
      cell?.configCell(withEventItemModel: model)
    }
    
    return cell!
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
  }
  
  // MARK: UITableViewDelegate
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    self.currentSelectedIndexPath = indexPath
    self.showAlert("提示", message: "点击确定会设置为完成，点击取消会设置为未完成")
  }
  
  // MARK: Event Handler Methods
  func onAddItemHandler(sender: UIBarButtonItem) {
    let addController = AddEventItemController { (model) -> Void in
      // 将新添加的数据添加到数据源，并更新显示
      self.dataSource.append(model)
      self.tableView.reloadData()
    }
    self.navigationController?.pushViewController(addController, animated: true)
  }
  
  // MARK: UIAlertViewDelegate
  func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
    if buttonIndex == 1 {
      self.updateState(isCompleted: true)
    } else {
      self.updateState(isCompleted: false)
    }
  }
  
  // MARK: Private Helper Methods
  private func showAlert(title: String?, message: String?) {
    if #available(iOS 8.0, *) {
      let alert = UIAlertController(title: title,
        message: message,
        preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "取消",
        style: UIAlertActionStyle.Cancel,
        handler: { (action) -> Void in
          self.updateState(isCompleted: false)
      }))
      
      alert.addAction(UIAlertAction(title: "确定",
        style: UIAlertActionStyle.Default,
        handler: { (action) -> Void in
          self.updateState(isCompleted: true)
      }))
      
      self.presentViewController(alert, animated: true, completion: nil)
    } else {
      let alert = UIAlertView(title: title, message: message, delegate: self, cancelButtonTitle: "取消")
      alert.addButtonWithTitle("确定")
      alert.show()
    }
  }
  
  private func updateState(isCompleted completed: Bool) {
    if let indexPath = self.currentSelectedIndexPath {
      let model: EventItemModel = self.dataSource[indexPath.row]
      model.isCompleted = completed
      
      self.tableView.reloadData()
    }
  }
}

