//: [Previous](@previous)

import Foundation

// 第七节：枚举

// 默认为Int
enum Direction {
  case North
  case South
  case East
  case West
}

let direction = Direction.South
switch direction {
case .North:
  print("north")
case .South:
  print(direction)
case .East:
  print("east")
case .West:
  print("west")
}

// 声明枚举时，如果类型不是整型，则都需要指定raw value
enum RelationShip: String {
  case Father = "Father"
  case Mother = "Mother"
  case Brother = "Brother"
  case Sister = "Sister"
  case Unknown = "Unknown relation ship"
  
  // 可以定义方法
  func showRawValue() {
    print(self.rawValue)
  }
  
  // 如果要修改值，需要使用mutating才行
  mutating func updateNewValue(relationShip: RelationShip) {
    self = relationShip
  }
}

var relation = RelationShip(rawValue: "Father")// 可以使用构造函数构造
relation!.showRawValue()
relation?.updateNewValue(.Mother)
print(relation!.rawValue)


//
enum HTTPError {
  case HttpProtocol(String)
  case Error(Int, String)
}

var http = HTTPError.HttpProtocol("https://")
http = HTTPError.Error(404, "HTTP Not Found")
switch http {
case .HttpProtocol(let httpProtocol) where httpProtocol.hasPrefix("://"):
  print("https://")
case let .Error(code, msg) where code == 404:
  print(msg)
default:
  print("no case")
}
