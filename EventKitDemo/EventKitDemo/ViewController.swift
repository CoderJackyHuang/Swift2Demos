//
//  ViewController.swift
//  EventKitDemo
//
//  Created by huangyibiao on 15/9/15.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import UIKit
import EventKitUI

/// 学习事项提醒EventKit基础功能
///
/// - Note:
/// - Blog: http://www.hybblog.com/
/// - Email: huangyibiao520@163.com
/// - Github: https://github.com/632840804/
/// - 微博：JackyHuang标哥
/// - QQ群：324400294
class ViewController: UIViewController, EKEventEditViewDelegate {
  /// 事项存储库，对应数据库
  var eventStore = EKEventStore()
  /// 存储事项唯一标识
  var eventIdentifiers = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  // MARK: Event Handler Methods
  //
  /// 添加事项提示响应回调
  /// 
  /// - sender: 响应的按钮
  @IBAction func onAddEventRemindHandler(sender: UIButton) {
    /// 首先要询问用户是否授权访问日历事项
    eventStore.requestAccessToEntityType(EKEntityType.Event) { (isGranted, error) -> Void in
      guard isGranted && error == nil  else {
        print("用户未授权")
        return
      }
      
      let editController = EKEventEditViewController()
      editController.eventStore = self.eventStore
      editController.editViewDelegate = self
      self.presentViewController(editController, animated: true, completion: nil)
    }
  }

  /// 移除事项提示响应回调
  ///
  /// - sender: 响应的按钮
  @IBAction func onRemoveEventRemindHandler(sender: UIButton) {
    guard !self.eventIdentifiers.isEmpty else {
      return
    }
    
    for identifier in self.eventIdentifiers {
      if let event = self.eventStore.eventWithIdentifier(identifier) {
        do {
          try self.eventStore.removeEvent(event, span: EKSpan.ThisEvent, commit: false)
        } catch {
          print("error for remove event \(identifier)")
        }
      }
    }
    
    do {
      try self.eventStore.commit()
      print("删除成功")
    } catch {
      print("commit throws an erro")
    }
  }
  
  // MARK: EKEventEditViewDelegate
  func eventEditViewController(controller: EKEventEditViewController, didCompleteWithAction action: EKEventEditViewAction) {
    guard action != EKEventEditViewAction.Canceled else {
      self.dismissViewControllerAnimated(true, completion: nil)
      return
    }
    
    var found = false
    var index = 0
    for identifier in self.eventIdentifiers {
      if controller.event?.eventIdentifier == identifier {
        found = true
        break
      }
      index++
    }

    if action == EKEventEditViewAction.Saved {
      if !found {
        self.eventIdentifiers.append(controller.event!.eventIdentifier)
      }
    } else if action == EKEventEditViewAction.Deleted {
      if found {
        self.eventIdentifiers.removeAtIndex(index)
      }
    }
    
    // 这里只需要退出即可
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}

