//
//  AddEventItemController.swift
//  ToDoListDemo
//
//  Created by huangyibiao on 15/9/14.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation
import UIKit

/// 添加事项界面
///
/// - Note:
/// - Blog: http://www.hybblog.com/
/// - Email: huangyibiao520@163.com
/// - Github: https://github.com/632840804/
/// - 微博：JackyHuang标哥
/// - QQ群：324400294
class AddEventItemController: UIViewController, UITextFieldDelegate {
  // MARK: Private Properties
  private var nameTextField: UITextField!
  private var addEventItemSuccessHandler: ((EventItemModel) ->Void)?
  
  // MARK: 构造函数
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  convenience init(successHandler: ((EventItemModel) ->Void)?) {
    self.init(nibName: nil, bundle: nil)
    
    self.addEventItemSuccessHandler = successHandler
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "半包反向传值"
    self.view.backgroundColor = UIColor.whiteColor()
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成",
      style: UIBarButtonItemStyle.Plain,
      target: self,
      action: "onFinishedHandler:")
    
    let screenWidth = UIScreen.mainScreen().bounds.width
    self.nameTextField = UITextField(frame: CGRectMake(50, 100, screenWidth - 100, 35))
    self.nameTextField.delegate = self
    self.nameTextField.borderStyle = UITextBorderStyle.RoundedRect
    self.view.addSubview(self.nameTextField)
  }
  
  // MARK: Event Handler
  func onFinishedHandler(sender: UIBarButtonItem) {
    guard (self.nameTextField.text?.isEmpty != true) else {
      return
    }
    
    if let handler = self.addEventItemSuccessHandler {
      let eventItemModel = EventItemModel()
      eventItemModel.itemName = self.nameTextField.text!
      eventItemModel.createdDate = NSDate()
      
      handler(eventItemModel)
    }
    
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  // MARK: UITextFieldDelegate
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    self.view.endEditing(true)
    
    return true
  }
}

