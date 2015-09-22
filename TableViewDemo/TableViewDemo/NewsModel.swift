//
//  NewsModel.swift
//  TableViewDemo
//
//  Created by huangyibiao on 15/9/13.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation

/// The model of a news
///
/// - Note:
/// - Blog: http://www.hybblog.com/
/// - Email: huangyibiao520@163.com
/// - Github: https://github.com/632840804/
/// - 微博：JackyHuang标哥
class NewsModel: NSObject {
  /// The news' title
  var title = ""
  
  /// The description of a news.
  var summary = ""
  
  /// The author of a news, default is now.
  var author = "huangyibiao"
}

// 1、构造函数
class Vehicle: NSObject {
  var passengers: Int
  var wheels: Int
  var maxPassengers: Int
  
  // 不允许重写
  final var color: Int
  
  // 重写NSObject的init
  override init() {
    // 初始化我们要做的事
    passengers = 0
    wheels = 0
    color = 0
    maxPassengers = 20
    
    // 再调用父类的，顺序不能相反
    super.init()
  }
  
  init(maxPassengers: Int = 2, wheels: Int = 2) {
    self.wheels = wheels
    self.maxPassengers = maxPassengers
    passengers = 0
    color = 0
    
    super.init()
  }
  
  init(passengers: Int, maxPassengers: Int, wheels: Int, color: Int) {
    self.passengers = passengers
    self.maxPassengers = maxPassengers
    self.wheels = wheels
    self.color = color
    
    super.init()
  }
  
  // 使用convenience来声明的方便构造器，必须要调用本类定义的构造器
  convenience init(passengers: Int, wheels: Int) {
    self.init(maxPassengers: 20, wheels: 2)// 不是super.init
    
    // 再初始化我们的
    self.passengers = passengers
  }
  
  // convenience构造器之间是可以互调的，但是至少要有一个convenience构造器直接
  // 调用了本类的designated构造器
  convenience init(passengers: Int, wheels: Int, color: Int) {
    self.init(passengers: passengers, wheels: wheels)
    
    self.color = color
  }
  
  func showDescription() {
    print("passgeners=\(passengers), wheels = \(wheels), color = \(color)")
  }
}

// 定义一个单车类
class Bicycle: Vehicle {
  // 常量属性只能通过初始值设置或者通过构造器设置值
  var constant: Int
    
  // 属性观察器
  override var passengers: Int {
    didSet {
      print("passengers new value is \(self.passengers)")
    }
    
    willSet {
      print("passengers new value will be set to be \(self.passengers)")
    }
  }
  
  init(passengers: Int, wheels: Int, constant: Int) {
    self.constant = constant
    
    super.init(passengers: passengers, maxPassengers: 2, wheels: wheels, color: 0)
  }
  
  // 重写方法
  override func showDescription() {
    print("passgeners=\(passengers), wheels = \(wheels), color = \(color)")
  }
}


