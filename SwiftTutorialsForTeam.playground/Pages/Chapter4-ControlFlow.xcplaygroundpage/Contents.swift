//: [Previous](@previous)

import Foundation

// 第四节：控制流

// 1、for、for-in
let array = [1, 5, 3, 6, 2, 7]
for var index = 0; index < array.count; ++index {
  print(array[index])
}

for item in array {
  print(item)
}

var sum = 0
for _ in 1...5 {
  sum += 1
}
print(sum)//5

sum = 0
for _ in 1..<5 {
  sum += 1
}
print(sum)//4

// 2、while、repeat
var index = 10
while index > 0 {
  index--
}
print(index)// 0

index = 0
repeat {// 没有do-while了，只有repeat-while
  print("test repeat")
  index++
} while index < 3

// 3、If、guard
if index == 3 {
  print("3")
}

var dict = ["name": "peter love"]

// guard语法是守卫条件，如果条件为真，什么也不干，否则进入else分支
// 通常用于抛出异常、直接返回等
func printDict(dict: [String: String]) {
  guard let name = dict["name"] else {
    return
  }
  
  print(name)
  
  // 可以添加where条件过滤
  guard let peter = dict["name"] where name.hasPrefix("peter") else {
    return
  }
  
  print(peter)
  
  guard let subfix = dict["name"] where name.hasSuffix("loveyou") else {
    return
  }
  
  // 不会打印出来
  print(subfix)
}

printDict(dict)


// 4、switch
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

// 不再需要使用Break跟着，默认会自动添加
// 如果需要强制执行完后，继续再走一个分支，需要使用fallthrough
switch relation! {
case .Father:
  print("Father")
case .Mother:
  print("Mother")
  fallthrough // 不会去判断下一个分支的条件是否满足，都会贯穿下一分支
case .Brother:
  print("Brother")
default:
  print("Unknown relation ship")
}


let point = (1, 3)
switch point {
case let (x, y) where x > y:
  print("x > y")
case let (x, _) where x > 2:
  print("x > 2")
case let (1, y) where y > 4:
  print("y > 4 and x == 1")
case let (x, y) where x >= 1 && y <= 10:
  print("ok")// ok
default:
  print("error")
}






