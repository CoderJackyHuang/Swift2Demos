//
//  EventItemModel.swift
//  ToDoListDemo
//
//  Created by huangyibiao on 15/9/14.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation


/// 事项模型
///
/// - Note:
/// - Blog: http://www.hybblog.com/
/// - Email: huangyibiao520@163.com
/// - Github: https://github.com/632840804/
/// - 微博：JackyHuang标哥
/// - QQ群：324400294
class EventItemModel: NSObject {
  /// 事项名
  /// 没必要这么声明：var itemName: String?
  /// 直接使用初始化方式，交给编译器自动推断出类型就可以了
  var itemName = ""
  
  /// 事项是否已经完成
  /// 个人更喜欢使用类型推断，不太喜欢使用可选方式声明这种普通类型变量
  var isCompleted = false
  
  /// 创建日期
  /// 默认为当前日期即可
  var createdDate = NSDate()
}