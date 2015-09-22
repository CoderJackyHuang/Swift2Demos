//: [Previous](@previous)

import Foundation

// 第八节：结构体

/*
类和结构体对比

Swift 中类和结构体有很多共同点。共同处在于：

定义属性用于存储值
定义方法用于提供功能
定义附属脚本用于访问值
定义构造器用于生成初始化值
通过扩展以增加默认实现的功能
实现协议以提供某种标准功能
更多信息请参见 属性，方法，下标脚本，初始过程，扩展，和协议。

与结构体相比，类还有如下的附加功能：

继承允许一个类继承另一个类的特征
类型转换允许在运行时检查和解释一个类实例的类型
解构器允许一个类实例释放任何其所被分配的资源
引用计数允许对一个类的多次引用
*/


struct Resolution {
  var width = 0
  var height = 0
  static var count = 0
  
  // 如果没有定义，则会自动生成一个成员逐一构造器，如果有定义，则不会生成
  // 注掉与打开是一样的
//  init(width: Int, height: Int) {
//    self.width = width
//    self.height = height
//  }
  
  func showResolution() {
    print("width = \(width), height = \(height)")
  }
  
  // 需要加上mutating
  mutating func update(width width: Int) {
    self.width = width
  }
  
 
  mutating func update(height height: Int) {
    self.height = height;
  }
  
  // 静态方法
  static func showCount() {
    count++
    print(count)
  }
}

var resolution = Resolution(width: 1024, height: 1024)
print(resolution.width)
print(resolution.height)
resolution.showResolution()//width = 1024, height = 1024

// 这两个是一样的
resolution.width = 100
resolution.update(width: 100)

// 一样
resolution.height = 100
resolution.update(height: 100)

// width = 100, height = 100
resolution.showResolution()

// 类型调用，不能是变量调用
Resolution.showCount()
Resolution.showCount()
