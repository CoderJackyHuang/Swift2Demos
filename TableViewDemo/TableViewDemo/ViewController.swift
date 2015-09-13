//
//  ViewController.swift
//  TableViewDemo
//
//  Created by huangyibiao on 15/9/13.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import UIKit

/// 一起来学习UITableView相关基础知识
///
/// - Note:
/// - Blog: http://www.hybblog.com/
/// - Email: huangyibiao520@163.com
/// - Github: https://github.com/632840804/
/// - 微博：JackyHuang标哥
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate {
  /// 表格的数组源
  var dataSource: [NewsModel]!
  
  /// 表格对象
  var tableView: UITableView!
  
  /// 记录将要删除的行，主要是用UIAlertView时，是需要在代理回调时
  /// 才删除
  var deletingIndexPath: NSIndexPath?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    /// 构造数据，先创建空数组
    self.dataSource = [NewsModel]()
    for var i = 0; i < 10; ++i {
      let model = NewsModel()
      model.title = "欢迎一起来学习UITableView相关基础知识\(i+1)"
      model.summary = "Blog：http://www.hybblog.com/ \n Github：https://github.com/632840804/"
      model.author = "Jacky Huang"
      
      self.dataSource.append(model)
    }

    let tableView = UITableView(frame: self.view.bounds)
    self.view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    self.tableView = tableView
  }

  // MARK: UITableViewDataSource
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier = "NewsCellIdentifier"
    var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
    
    if cell == nil {
      cell = NewsCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
    }
    
    if let newsCell = cell as? NewsCell {
      let model: NewsModel = self.dataSource[indexPath.row]
      newsCell.configCell(WithNewsModel: model)
    }
    
    return cell as! NewsCell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dataSource.count
  }
  
  /// 设置可删除
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  /// 删除
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == UITableViewCellEditingStyle.Delete {
      deletingIndexPath = indexPath
      
      self.showDeleteAlert("提示", message: "您确定要删除吗？", okHandler: { () -> Void in
        self.deleteRow(deletedPath: indexPath)
      })
    }
  }
  
  // MARK: UITableViewDelegate
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 140.0
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.showAlert("您选中的是第\(indexPath.row + 1)行",
      message: "恭喜！您已经基础掌握UITableView的基础使用知识了！！！")
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  /// 显示只有确定按钮提示警示框
  ///
  /// - title: 提示标题
  /// - message: 提示信息
  func showAlert(title: String?, message: String?) {
    if #available(iOS 8.0, *) {
     let alert = UIAlertController(title: title,
      message: message,
      preferredStyle: UIAlertControllerStyle.Alert)
      
      alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil))
      
      self.presentViewController(alert, animated: true, completion: nil)
    } else {
      UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "确定").show()
    }
  }
  
  /// 显示删除提示警示框
  ///
  /// - title: 提示标题
  /// - message: 提示信息
  /// - okHandler: 点击确定后的回调
  func showDeleteAlert(title: String?, message: String?, okHandler: (() ->Void)?) {
    if #available(iOS 8.0, *) {
      let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
      
      alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Default, handler: nil))
      alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
        if let handler = okHandler {
          handler()
        }
      }))
      
      self.presentViewController(alert, animated: true, completion: nil)
    } else {
      let alert = UIAlertView(title: title, message: message, delegate: self, cancelButtonTitle: "取消")
      alert.addButtonWithTitle("确定")
      alert.show()
    }
  }
  
  //
  // MARK: UIAlertViewDelegate
  func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
    if buttonIndex == 1 {// 确定删除
      if let indexPath = deletingIndexPath {
        deleteRow(deletedPath: indexPath)
      }
    }
  }
  
  // MARK: Private
  func deleteRow(deletedPath indexPath: NSIndexPath) {
    dataSource.removeAtIndex(indexPath.row)
    
    // 在调用deleteRowsAtIndexPaths API之前，最好先调用beginUpdates，且在删除后调用endUpdates
    tableView.beginUpdates()
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    tableView.endUpdates()
  }
}

