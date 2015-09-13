
import Foundation

/*
##环境
```
//: 环境：xcode7 beta6
//: swift2.0 枚举学习记录
```
*/

//##1、介绍
/*在 Swift 中，枚举类型采用了很多传统上只被类（class）所支持的特征，例如计算型属性（computed properties），用于提供关于枚举当前值的附加信息， 实例方法，用于提供和枚举所代表的值相关联的功能。枚举也可以定义构造函数（initializers）来提供一个初始值；可以在原始的实现基础上扩展它们的功能；可以遵守协议来提供功能。*/

//##2、枚举语法
//使用enum关键词来创建枚举并且把它们的整个定义放在一对大括号内：

enum enumationDefine {
  // enumeration definition goes here
}

// 写一个方向枚举例子
enum Direction {
  case Top
  case Bottom
  case Left
  case Right
}

// >注意：swift中的枚举不会自动给一个默认值

// 初始化为top，自动推断出来类型为Direction枚举类型
var direction = Direction.Top
// 确定了类型后，可以直接类型前面的类型，以.+成员
direction = .Bottom

//##3、匹配枚举值和switch
// 可以直接使用.Right形式，也可以完整写出来
switch direction {
case .Top:
  print("top")
case .Bottom:
  print("bottom")
case .Left:
  print("left")
case Direction.Right:
  print("right")
}

