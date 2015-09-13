//: [Previous](@previous)

import Foundation


//: 环境：xcode7 beta6
//: swift2.0基础部分记录

// 1、常量与变量
// 常量和变量必须在使用前声明，用let来声明常量，用var来声明变量
// 常量在声明时，要求初始化，且不能更改
// 对于常量命名，个人更喜欢以小写的k开头，后面的单词首字母大写，其余小写
let kMaxLength = 100
// 用var声明变量，命名使用使用驼峰命名法
var maxCount = 100

// 2、类型自动推荐
// 推出类型为Int <=> var x: Int = 1
var x = 1

// 3、可以一行声明多个变量
// 如果可以一行声明多个变量，但是建议不要这么做，一行声明一个更可读
var x1 = 0, x2 = 1, x3 = 2

// 4、类型标注
// 变量声明时，可以明确指定类型
var xx: Int = 0

// 5、分号
// 在swift中分号是可有可无的
var seg = 1;
var seg1 = 1

// 6、整数
// Swift 提供了8，16，32和64位的有符号和无符号整数类型。分别为：
// (U)Int8,16,,32,64
//
// 定义有符号整数，基本都是使用Int就可以了
// Int
// 一般来说，你不需要专门指定整数的长度。Swift 提供了一个特殊的整数类型Int，
// 长度与当前平台的原生字长相同：
//
// 在32位平台上，Int和Int32长度相同。
// 在64位平台上，Int和Int64长度相同。
var number: Int = 10
print(Int.max)
print(Int.min)

// 7、二进制、八进制、十进制、十六进制表示法
// 一个十进制数，没有前缀
// 一个二进制数，前缀是0b
// 一个八进制数，前缀是0o
// 一个十六进制数，前缀是0x
var decInt = 17
var binInt = 0b10001
var octInt = 0o21
var hexInt = 0x11

// 8、整数和浮点数转换
var intType = 10
var doubleType = 10.0
// 报错，类型不一致，必须手动转换
//intType = doubleType
intType = Int(doubleType)

// 9、类型别名
// 使用typealias声明，别名 = 原名
typealias IntType = Int
let valueObject: IntType = 10
print(valueObject)

// 10、真假值
// Swift中的真假值用true,false表示，与objective-c中的YES,NO表示的意思一样
var isDoing: Bool = false

// 11、控制语句中不会自动转换成bool类型
let obj = 1
//if obj {
//  print("编译不能通过")
//}
if obj == 1 {
  print("OK，用obj==1判断，会返回Bool类型值")
}

// 12、元组类型
// swift中增加了元组类型，元组内的值可以是任意类型，并不要求是相同类型。
// 声明方式，直接用圆括号
let http404NotFound = (404, "Not Found")
// 可以用.0,1,2...访问值
print(http404NotFound.0)
print(http404NotFound.1)

// 如果只要其中一部分值，可以用_过滤
let (httpCode, _) = http404NotFound
print(httpCode)

// 可以给元组中的每个元素全名
let httpStatus = (code: 404, description: "Not Found")
print(httpStatus.code)
print(httpStatus.description)

// 13、可选类型，可能有值，也可能为空
// 用？表示可选类型，通过用可选绑定判断是否有值
var optionalValue: Int?
if let value = optionalValue {
  print("有值的")
} else {
  print("是空的")
}

optionalValue = 10
if let value = optionalValue {
  print("有值的")
} else {
  print("是空的")
}

// 多个可选类型
var op1: Int?
var op2: Int?
op1 = 1
// 对于多个可选，只有都有值才会执行{}内的内容
if let lhs = op1, rhs = op2 {
  print("都有值")
} else {
  print("不都有值")
}

op2 = 2
if let lhs = op1, rhs = op2 {
  print("都有值")
} else {
  print("不都有值")
}

// 14、隐式解析可选类型
// 如果变量一开始没有值，但是一旦赋值后，保证一直有值，则可以用!来声明
var name: String! // 后面会有值
name = "我会有值的"
print(name)// 使用时不用加!

// 可以使用！，也可以不使用，但是一定要保证有值，否则会crash
var lili: String = name!
print(lili)

// 14、错误处理
// swift中提供了异常处理机制，使用throws抛出异常，交由外部处理
enum LessThanErrorType : ErrorType {
  case LessThanZero
}

func throwErrorFunc(number: Int) throws {
  if number <= 0 {
    throw LessThanErrorType.LessThanZero
  }
  
  print("number = \(number)")
}

// 调用的地方需要处理异常
func callIt() {
  do {
    try throwErrorFunc(-1)
  } catch {
    print("number less than zero")
  }
}

callIt()






