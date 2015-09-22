//: [Previous](@previous)

import Foundation

// 第十三节：协议
/*
协议可以规定其遵循者提供特定名称和类型的实例属性(instance property)或类属性(type property)，而不指定是存储型属性(stored property)还是计算型属性(calculate property)。此外还必须指明是只读的还是可读可写的。

如果协议规定属性是可读可写的，那么这个属性不能是常量或只读的计算属性。如果协议只要求属性是只读的(gettable)，那个属性不仅可以是只读的，如果你代码需要的话，也可以是可写的。

协议中的通常用var来声明属性，在类型声明后加上{ set get }来表示属性是可读可写的，只读属性则用{ get }来表示。
*/

protocol SomeProtocol {
  // 声明为可读可写的属性，用get set，并且不能在协议中有具体实现
  var readWriteVariable: Int { get set }
  // 声明为只读属性
  var readableVariable: Int { get }
  // 注意，不能声明为只写属性
//  var writableVariable: Int { set }
  // 静态属性声明
  // 静态属性在协议中只能使用static关键字声明，如果是类遵守协议，可以使用class或者static来
  // 声明类属性，对于结构体、枚举等遵守协议，必须使用static来声明
  static var staticVariable: Int { get set }
}

protocol FullyNameProtocol {
  var fullName: String { get } // 只读
}
struct Person: FullyNameProtocol {
  var fullName: String // 由于遵守了FullyNameProtocol，因此必须实现其协议属性或方法
}
let john = Person(fullName: "John Google")

class Startship: FullyNameProtocol {
  var prefix: String?
  var name: String
  
  // MARK: FullyNameProtocol
  var fullName: String { // 只读计算属性
    return (prefix != nil ? prefix! : " ") + name
  }
  
  init(name: String, prefix: String? = nil) {
    self.name = name
    self.prefix = prefix
  }
}