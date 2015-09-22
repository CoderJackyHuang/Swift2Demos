//: [Previous](@previous)

import Foundation

// 第五节：函数

// 函数定义方式：func 函数名称(arg...) ->ReturnValue
func testFunc() {
  // 无参数，无返回值
}

func testArgFunc(arg: Int) ->Void {
  // 无返回值可以使用Void，其实是空元组
}

func calSum(array: Int...) ->Int {
  var sum = 0
  
  for item in array {
    sum += item
  }
  
  return sum
}

calSum(1, 2, 3) // 6

// 函数重载
func calSum(array: [Int]) ->Int {
  var sum = 0
  
  for item in array {
    sum += item
  }
  
  return sum
}

calSum([1, 2, 3])// 6

// 多个参数
func multipleFunc(arg1: Int, arg2: Int) ->Int {
  return 0
}

multipleFunc(1, arg2: 1)// 第一个是不需要标签的，第二个是必须的，这叫外部变量
// 如果我们不需要外部显示，可以用_过滤
func multipleFunc1(arg1: Int, _ arg2: Int) ->Int {
  return 0
}
multipleFunc1(1, 2)


// Swift中的函数可以嵌套
typealias VoidFunc = () ->Void
var globalValue = 0
func nestedFunc(big: Bool) ->VoidFunc {
  func bigFunc() {
    globalValue++
  }
  
  func smallFunc() {
    globalValue--
  }
  
  if big {
    return bigFunc
  }
  
  return smallFunc
}

nestedFunc(true)() // 看起来比较怪异
print(globalValue)
// 改一种写法
let small = nestedFunc(false)
small()// 调用函数
print(globalValue)


