//: Playground - noun: a place where people can play

import UIKit

// 第一节：基础部分（包括可选）

// 1、常量与变量
// 使用let声明常量，声明时需要给定确定的值，不可再更改
let constant = 10
// 想要修改值类型，会在编译前提示错误
//constant = 11
// 使用var声明常量，可以修改值
var variable = 10
variable = 11

// 2、指定常量/变量的类型
// 方式：var/let name: Type来声明，可以指定初始值
let constValue = 10
var variableValue: String = "这是字符串"

// 3、类型转换
// 不会默认转换，只能强制转换
var doubleValue = 10.0
// 提示Double不能转换成Int类型
//var intValue: Int = doubleValue
// 通过使用构造方法来构造转换类型
var intValue: Int = Int(doubleValue)

// 4、类型别名
// 使用typealias来给一个已经存在的类型指定别名
// 方式：typealias 别名 = 已存在类型名
typealias AudoSample = Int

// 5、布尔值
// 不再是YES/NO，而是true/false
let boolValue = true
let isSuccess = false

// 6、元组
// 声明元组的方式很简单，圆括号包起来，且元素的类型可以是任意类型
let httpError = (404, "Http Not Found!")
// 也可以给元素指定名称
let httpError1 = (errorCode: 404, errorMessage: "Http Not Found")
// 可以通过.加上0，1，2...来访问元素，如果有名称，可以使用名称获取值
httpError.0 // 404
httpError1.errorCode // 404
httpError.1 // Http Not Found
httpError1.errorMessage // Http Not Found
httpError1.1

// 7、可选类型
// 声明可选类型可以用?或者!
// 其中用?与!的区别在于后者在使用时，不需要判断是否空，但是如果在使用时值为空，会Crash
var optionalValue: String?
optionalValue = "nonnull"
if let value = optionalValue {
  if value.isEmpty {
    print("optionalValue没有值")
  } else {
    print(value)
  }
}

optionalValue = "对于optional类型，访问是通常使用可选绑定方式"
if let value = optionalValue {
  print(value)
}

//var intValue1: Int?
//intValue1 = 1
//if var value = intValue1 {
//  value++
//  print(value)
//}


// 如果有多个，使用带号分开，只有所有都有值，也就是解绑成功，才是成功
// let binding
var optionalValue1: String?
if var value = optionalValue, value1 = optionalValue1 {
  print("两个都不为空")
} else {
  if let value = optionalValue {
    print("optionalValue1为空，optionalValue不为空")
  } else {
    print("optionalValue为空，optionalValue1不为空")
  }
}

if optionalValue != nil {
  print(optionalValue)
  if optionalValue!.isEmpty {
    
  }
}

// 使用!来强制告诉编译器，这个变量一旦赋值，不会为空。专业术语叫：隐式解析
var optoinalValue2: String!
// 使用时不需要用可选绑定就可以直接访问，但是如果没有值，会crash
// 在UI构建时，通常会使用!的方式来声明，因为一旦初始化，就不会为空，这样访问起来更方便更简洁
// crash信息：fatal error: unexpectedly found nil while unwrapping an Optional value
//optoinalValue2.isEmpty
optoinalValue2 = "有值以后就可以直接访问了"
optoinalValue2.isEmpty // false

// 8、断言
// 断言通常是用于诊断条件是否满足，如果不能满足就会中断程序
assert(optoinalValue2.isEmpty == false)// 条件为真，跟什么都没做一样
// assertion failed: : file <EXPR>, line 86
//assert(optoinalValue2.isEmpty == true)
// 我们也可以传失败信息
// assertion failed: optoinalValue2不为空: file <EXPR>, line 89
//assert(optoinalValue2.isEmpty == true, "optoinalValue2不为空")
// 还提供了直接断言失败的API：
// fatal error: : file <EXPR>, line 92
//assertionFailure()
// 也支持断言失败提示信息：
// fatal error: 反正是失败了: file <EXPR>, line 96
//assertionFailure("反正是失败了")

// 9、错误处理
// 在函数返回值之前参数之后添加关键字throws就可以将异常抛出来，让外部捕获处理
func canThrowAnErrow() throws ->Bool {
  // 这个函数有可能抛出错误
  return true
}
// 在调用的地方使用do{try ...} catch {}来处理异常
do {
  try canThrowAnErrow()
  // 继续做其它事...
} catch {
  // 可以分别捕获不同的异常处理，这里直接捕获所有异常
}
