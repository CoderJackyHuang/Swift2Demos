//
//  EventItemCell.swift
//  ToDoListDemo
//
//  Created by huangyibiao on 15/9/14.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation
import UIKit

/// 事项单元cell
///
/// - Note:
/// - Blog: http://www.hybblog.com/
/// - Email: huangyibiao520@163.com
/// - Github: https://github.com/632840804/
/// - 微博：JackyHuang标哥
/// - QQ群：324400294
class EventItemCell: UITableViewCell {
  // MARK: 私有属性
  /// 事项名称
  private var eventNameLabel: UILabel!
  /// 事项创建日期
  private var eventCreateDateLabel: UILabel!
  
  // MARK: 构造函数
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    let screenWidth = UIScreen.mainScreen().bounds.width
    self.eventNameLabel = UILabel(frame: CGRectMake(10, 10, screenWidth - 20, 20))
    self.contentView.addSubview(self.eventNameLabel)
    
    self.eventCreateDateLabel = UILabel(frame: CGRectMake(10, 40, screenWidth - 20, 20))
    self.eventCreateDateLabel.textAlignment = NSTextAlignment.Right
    self.eventCreateDateLabel.textColor = UIColor.lightGrayColor()
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: 公开API
  func configCell(withEventItemModel eventModel: EventItemModel?) {
    if let model = eventModel {
      self.eventNameLabel.text = model.itemName
      self.eventCreateDateLabel.text = model.createdDate.description
      
      if model.isCompleted {
        self.accessoryType = UITableViewCellAccessoryType.Checkmark
      } else {
        self.accessoryType = UITableViewCellAccessoryType.None
      }
    }
  }
}