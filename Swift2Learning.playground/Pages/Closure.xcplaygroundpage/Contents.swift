//: [Previous](@previous)

import Foundation


/*
##环境
```
//: 环境：xcode7 beta6
//: swift2.0 闭包学习记录
```
*/

/*
##介绍
闭包是自包住的函数代码块，可以被传递和使用，与objective-c中的block类似，与lambda表达式类似。
闭包可捕获和存储其上下文中所使用的常量和变量，并自动为我们处理内存问题。

函数中也有特殊的闭包：

* 全局函数：有名字，但不会捕获上下文中的值（特殊闭包）
* 嵌套函数：有名字，可以捕获所在函数内的上下文的常量和变量值（范围较小的闭包）
* 闭包表达式：轻量级的可捕获上下文的匿名闭包

Swift 的闭包表达式拥有简洁的风格，并鼓励在常见场景中进行语法优化，主要优化如下：

* 利用上下文推断参数和返回值类型
* 隐式返回单表达式闭包，即单表达式闭包可以省略return关键字
* 参数名称缩写
* 尾随（Trailing）闭包语法
*/

// ##1、标准库中sort函数
/*标准库提供了名为sort的函数，根据提供的用于排序的闭包函数将已知类型数组中的值进行排序。sort(_:)方法会返回一个排好序的数组，原数组不会被修改。
*/
let names = ["apple", "Apple", "Orange", "Egg", "egg"]
// 默认是从大到小排序
// [Apple,Egg,Orange,apple,egg]
print(names.sort())

for name in names.sort({ (name1, name2) -> Bool in
  // 对于简单表达式，推荐省略return来优化
  name1 > name2
}) {
  print(name)
}
// 打印结果：（从大到小排序）
// egg
// apple
// Orange
// Egg
// Apple

// 我们也可以先写一个简单函数，再将函数作为参数传给sort函数
// 升序排序
func asc(name1: String, name2: String) ->Bool {
  return name1 < name2
}
for name in names.sort(asc) {
  print(name)
}
// 打印结果：（从小到大）
// Apple
// Egg
// Orange
// apple
// egg

// ##2、闭包表达式的语法
/* 
```
{ (parameters) -> returnType in
  statements
}
```
> 闭包可以使用常量、变量和inout类型作为参数，不提供默认值,可在参数列表的最后使用可变参数,元组可作为参数和返回值。
*/

// 对于简单地闭包，可以写成一行
// 对于简单的判断，可以省略return
names.sort({ (name1, name2) -> Bool in name1 > name2 })
// 相当于，推荐使用省略写法
names.sort({ (name1, name2) -> Bool in return name1 > name2 })

// ##3、由上下文推断类型（省略写法）
// 闭包体内的参数和返回值有时候是可以自动推断出来的，因此可以省略（推荐省略写法）
// in 关键字不能省略，参数列表中的圆括号是可以省略的
// 这叫：单表达式闭包隐式返回
names.sort({ (name1, name2) in name1 > name2 })
// 相当于
names.sort({ name1, name2 in name1 > name2 })

// ##4、参数名称缩写
//Swift 自动为内联函数提供了参数名称缩写功能，您可以直接通过$0,$1,$2来顺序调用闭包的参数。
// 如果使用参数名称缩写，in关键字也是可以省略的
// 这里的$0表示第一个参数，$1表示第二个参数，依次类推
names.sort({ $0 > $1 })

// ##5、运算符函数
// 像sort这样的函数所需要的闭包中是返回Bool类型，且参数为两个，因此如果数组中的元素的类型重载了大于号或者小于号是可以直接使用的。不能使用{}了，直接使用即可，因为那就是函数名，与我们自己定义一个函数是一样的道理
names.sort(>)// 降序排序desc
names.sort(<)//升序（ASC）

//##5、尾随闭包（Tailing closure）
// 尾随闭包作为函数的最后一个参数，直接跟随函数后，也就是在()之后跟随，如果只有一个参数，且这个参数是这个闭包，则可以将()省略掉

func funcClosure(closure: () ->Void) {
  // Nothing
  closure()
}

// 使用尾随闭包前：
funcClosure({ () -> Void in
   print("hehe")
})

// 使用尾随闭包后：（不省略圆括号）
funcClosure() { () -> Void in
  print("haha")
}

// 使用尾随闭包后：（省略函数的圆括号）
funcClosure { () -> Void in
  print("heihei")
}

// ##6、标准库map过滤函数
let digitNames = [
  0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
  5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]
let resultString = numbers.map { (var digit) -> String in
  var output = ""
  while digit > 0 {
    // digitNames[digit % 10]后面跟着一个!，因为字典返回的是一个
    // optional类型的值
//    output += digitNames[digit % 10]!
    // 最好这么写，用值绑定来获取，更安全
    if let name = digitNames[digit % 10] {
      output += name
    }
    digit /= 10
  }
  
  return output
}
// [SixOne, EightFive, ZeroOneFive]
print(resultString)

//##7、闭包是引用类型
/*闭包是引用类型，多个常量或者变量闭包赋值给其他闭包，指向的都是同一个闭包。
*/
var number = 1
func closure() ->Void {
  number++
  print(number)
}

// 这两个是同一个闭包
let anotherClosure = closure
anotherClosure()// 2
closure() // 3

