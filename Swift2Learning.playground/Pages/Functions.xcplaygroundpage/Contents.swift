//: Playground - noun: a place where people can play

import UIKit

//: 环境：xcode7 beta6
//: swift2.0函数学习记录

//: 函数的定义与调用（Defining and Calling Functions）
/*
 swift中函数定义由关键字func + 函数名 + 参数列表 + 返回值类型
*/

//: 1、带外部变量、内部变量
//
/// isNormal叫外部变量，调用时会显示出现，以表明用途。normal叫内部变量，调用时不显示出来，是在函数
/// 实现的内部使用的。外部变量可以不指定。
///
func normalFunc(isNormal normal: Bool) ->String {
  return normal ? "This is a normal function" : "This is not a normal function";
}
print(normalFunc(isNormal: true))
print(normalFunc(isNormal: false))

//: 2、只有内部变量
//
/// 指定外部变量与不指定外部变量是两个不同的函数，编译器是可以区分出来的。
func normalFunc(normal: Bool) ->String {
  return normal ? "normal without outer variable." : "not a normal without outer variable"
}
print(normalFunc(true))
print(normalFunc(false))

//: 3、带默认参数
//
/// Swift中的参数可以指定默认值且不要求顺序
///
func normalFunc(normal: Bool = false, good: Bool) ->String {
  return good ? "he he " + normalFunc(isNormal: normal) : normalFunc(normal)
}
print(normalFunc(good: true))
print(normalFunc(good: false))
print(normalFunc(false, good: true))

//: 4、无参数函数
/// 无参数时，只用圆括号就可以了
func normalFunc1() ->String {
  return "这是固定的字符串"
}
normalFunc1()

//: 5、无参数无返回值
///
/// 无返回值可以不用箭头了，也可以用->Void,其实Void就是()，也就是空元组
func normalFunc2() {
  print("无参数无返回值")
}

normalFunc2()

func normalFuncWithReturnValue() ->Void {
  print("normalFuncWithReturnValue has ->Void")
}
normalFuncWithReturnValue()

//: 6、带多参数且带默认参数的
///
/// 默认参数可以是任意个，且不要求顺序
func hasMoreArg(one: Int, two: Int = 10, three: Int) -> String {
  return "one is \(one), two is \(two), three is \(three)"
}

print(hasMoreArg(10, three: 30))


//: 7、函数参数为数组
func arrayArgFunc(args: [Int]) ->Int {
  var sum = 0

  for value in args {
    sum += value
  }
  
  return sum
}

print(arrayArgFunc([1, 3, 5, 7]))

//: 8、函数参数为可变数组
func mutableArrayArgsFunc(numbers: Int...) ->Int {
  var sum = 0
  
  for value in numbers {
    sum += value
  }
  
  return sum
}
print(mutableArrayArgsFunc(1, 2, 3, 4))

//: 9、函数返回值为元组
func tupleReturnFunc(numbers: Int...) -> (max: Int, min: Int) {
  // 这里有小问题，边界没处理
  var currentMin = numbers[0]
  var currentMax = numbers[0]
  
  for value in numbers {
    if currentMax < value {
      currentMax = value
    } else if currentMin > value {
      currentMin = value
    }
  }
  
  return (currentMax, currentMin)
}

print(tupleReturnFunc(1, 5, 3))

//: 10、函数返回值为可空类型的元组
func nullableTupleFunc(numbers: Int...) -> (max: Int, min: Int)? {
  if numbers.count == 0 {
    return nil
  }
  
  var currentMin = numbers[0]
  var currentMax = numbers[0]
  
  for value in numbers {
    if currentMax < value {
      currentMax = value
    } else if currentMin > value {
      currentMin = value
    }
  }
  
  return (currentMax, currentMin)
}

if let bounds = nullableTupleFunc(1, 5, 19, 3, 7, 0) {
  print("max = \(bounds.max), min = \(bounds.min)")
}

//: 11、不标记外部变量的函数，用_来代替
// 如果你不想为第二个及后续的参数设置参数名,用一个下划线(_)代替一个明确地参数名.
func nonMarkOuterFunc(arg1: Int, _ arg2: Int) ->Int {
  return 0
}

print(nonMarkOuterFunc(1, 1))

//: 12、常量参数类型与变量参数类型
func varAndLetFunc(var arg1: String, let arg2: Int, arg3: Bool) {
  print("arg1被标记为变量参数，这样内部可以拥有可写权限；arg2和arg3都是常量类型，默认就是let声明的")
  arg1 = "被修改了，但是不会影响外部"
//  arg3 = 2// 这是不可以的，编译不能通过，因为let声明的是常量
}
varAndLetFunc("无所谓", arg2: 0, arg3: true)

//: 13、输入输出参数
/// 输入输出参数使用inout关键字声明，在调用时，需要使用&，表示内存的引用
func inoutArgFunc(inout arg1: Int, inout arg2: Int) {
  let tmp = arg1
  
  arg1 = arg2
  arg2 = tmp
}

var arg1 = 10
var arg2 = 20
inoutArgFunc(&arg1, arg2: &arg2)
print("交换后：arg1=\(arg1), arg2=\(arg2)")

//: 14、函数参数为函数，如果函数参数作为最后一个参数，则可以成为尾随闭包
typealias argFunc = (Bool) ->Bool
func funcAsArg(type: Int = 1, arg: argFunc) ->Int {
  if arg(type == 1) {
    return 100
  }
  
  return type
}
print(funcAsArg(arg: { (arg) -> Bool in
  return arg
}))
print(funcAsArg(10, arg: { (arg) -> Bool in
  return arg
}))

//: 15、返回值类型为函数、嵌套函数
typealias ReturnFunc = (Int) ->Int
func funcHaveReturnFunc(plus: Bool = true) ->ReturnFunc {
  func plusone(addOne: Int) ->Int {
    return addOne + 1
  }
  
  func minusone(minusOne: Int) ->Int {
    return minusOne + 1
  }
  
  return plus ? plusone : minusone
}

var result = 0
for i in 1...10 {
  // 这里这么写可能会很奇怪，尽量不要这么写法，分成两行来写
//  result = funcHaveReturnFunc(i % 2 == 0)(i)
  let resultFunc = funcHaveReturnFunc(i % 2 == 0);
  result = resultFunc(i)
  print(result)
}











