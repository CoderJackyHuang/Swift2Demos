//: [Previous](@previous)

import Foundation

/*
##环境
```
//: 环境：xcode7 beta6
//: swift2.0 控制流学习记录
```
*/

/* ##说明
Swift提供了类似C语言的控制结构，包括可以多次执行任务的for和while循环，基于特定条件选择执行不同代码分支的if和switch语句，还有控制流程跳转到其他代码的break和continue语句。还提供了guard,repeat,for-in等
*/


// ##1、for和for-in
/// ...是闭区间[0,5]
for index in 0...5 {
  print("\(index) times 5 is \(index * 5)")
}

// ..<是开区间[0,5)
for index in 0..<5 {
  print(index)
}

// 如果不需要使用，则可以用_代替
for _ in 0...5 {
  print("hehe")
}

// 遍历数组
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
  print(name)
}

for (index, value) in names.enumerate() {
  print("\(value)\'s index is \(index)")
}

for var index = 0; index < names.count; ++index {
  print("\(names[index])\'s index is \(index)")
}


// ##2、repeat-while
// while首先判断是否满足条件，满足条件才执行，所以执行次数大于等于零次
var condition = 10
// 不支持这么写了？
//where condition > 5 {
//  print(condition--)
//}

repeat {
  print(condition--)
} while condition >= 5

// 不能再用do-while了。
//do {
//  print(condition--)
//} while condition >= 0

// ##3、if、guard
// if语句不要求有else，要求为bool条件
var isGood = true
if isGood {
  print("good")
}

// ##4、switch
// switch与objective-c中的swift不一样了，不需要使用case，也就是说只会执行其中
// 一条，如果需要执行多条，需要使用fallthrough，也就是穿过的意思。另外swift中的
// switch必须强制写上default，除非case分支包含了所有的情况，否则统计不能通过
let letter = "A"
switch letter {
  case "A":
  print("A")
  case "B":
  print("B")
default:
  print("null")
}

// case 可以是范围匹配
let count = 12
switch count {
case 0:
  print("count = 0")
case 1..<5:
  print("count is between 1 and 4")
case 5...10:
  print("count is between 5 and 10")
default:
  print("count is less than zero or count is bigger than 12")
}

// case 可以是一个元组，匹配一个范围或者一组值
let centerPoint = (1, 1)
switch centerPoint {
case (0, 0), (0, 1):
  print("point is (0, 0) or (0, 1)")
case (_, 0):
  print("point's y is 1, regardless of x")
case (1, 2):
  print("point is (1, 2)")
case (1, 1):// 执行这里
  print("point is (1, 1)")
default:
  print("default: point is \(centerPoint)")
}

//> case分支允许将匹配的值绑定到一个临时的常量或变量，这些常量或变量在该case分支里就可以被引用了——这种行为被称为值绑定（value binding）
let point = (2, 0)
switch point {
case (let x, 0):
  print("When y is 0, the x is \(x)")
  // 当使用了值绑定后，不能使用fallthrough
//  fallthrough
case (2, let y):
  print("when x is 2, the y is \(y)")
default:
  print("Nothing to match")
}

// > case分支除了可以使用值绑定外，还可以增加where条件
let anotherPoint = (1, -1)
switch anotherPoint {
case let (x, y) where x == y:
  print("x == y, and point is (\(x), \(y))")
case let (x, y) where x == -y:
  print("x == -y and point is (\(x), \(y))")
default:
  print("Nothing to match")
}

// > fallthrough不能用在值绑定的case分支中，当使用了fallthrough后，不会去匹配下一个case，而是直接执行下一个case的内容
let next = 10
switch next {
case 10:
  print("next is 10")
  // 加上fallthrough后，不会管case 11条件是否满足，都会执行
  fallthrough
case 11:
  print("next is 11")
default:
  print("next is unknown")
}
// 打印结果：
// next is 10
// next is 11

// ##1、带标签的语句：
// 在循环体和switch代码块中嵌套循环体和switch代码块来创造复杂的控制流结构。然而，循环体和switch代码块两者都可以使用break语句来提前结束整个方法体。因此，显示地指明break语句想要终止的是哪个循环体或者switch代码块，会很有用。类似地，如果你有许多嵌套的循环体，显示指明continue语句想要影响哪一个循环体也会非常有用。
//> label name: while condition { statements }
var nextInt = 0
outerLoop: while nextInt < 100 {
  nextInt++
  
  if nextInt == 50 {
    print("50")
  }
  
  switch nextInt {
  case let (x) where x % 2 != 0:
    print("质数：\(x)")
    continue outerLoop
  case let x where x % 2 == 0 && x <= 50:
    print("50以内的偶数为：\(x)")
    continue outerLoop
  case 100:
    break outerLoop
  default:
    print("x is \(nextInt)")
  }
}

// ##6、guard语句
// >像if语句一样，guard的执行取决于一个表达式的布尔值。我们可以使用guard语句来要求条件必须为真时，以执行guard语句后的代码。不同于if语句，一个guard语句总是有一个else分句，如果条件不为真则执行else分局中的代码。
func greet(person: [String: String]) {
  // 如果没有name值，则退出
  guard let name = person["name"] else {
    // 可以直接返回，通常是抛异常
    return
  }
  
  print("name is \(name)")
  
  guard let location = person["loc"] else {
    // 可以直接用fatalError API，也可以自己定义Error，然后抛出来
    fatalError("The key loc is not found", file: "control-flows")
  }
  
  print("persion\'s name is \(name) and it\'s location is \(location)")
}


greet(["name": "Lili", "location": "Beijing"])

//##7、检测API是否可用
/*Swift 有内置支持去检查接口的可用性的，这可以保证API可用与否。
编译器使用SDK中的可用信息来验证在我们在可用部署目标指定项目的代码中所有的API调用。如果我们尝试使用一个不可用的API，Swift会在编译期报错。
我们使用一个可用性条件在一个if或guard语句中去有条件的执行一段代码，这取决于我们想要使用的API是否在运行时是可用的。编译器使用从可用性条件语句中获取的信息，这时它会去验证在代码块中调用的API是否都可用。
> 格式为：#available(iOS x, OSX y, *)，最后的*表示任意平台上可用。通常这么用：
```
if #available(iOS 9, OSX 10.10, *) {
  // 在 iOS 使用 iOS 9 APIs , 并且在 OS X 使用 OS X v10.10 APIs
} else {
  // 回滚至早前 iOS and OS X 的API
}
```
*/
