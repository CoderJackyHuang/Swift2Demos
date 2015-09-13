//: [Previous](@previous)

import Foundation

//: 环境：xcode7 beta6
//: swift2.0 String记录
/*
 Swift中的String与Objective-C中的NSString是无缝桥接的。在使用 Cocoa 中的 
 Foundation 框架时，可以将创建的任何字符串的值转换成NSString，并调用任意的
 NSString API。也可以在任意要求传入NSString实例作为参数的 API 中用String类
 型的值代替。
*/

// 1、字符串字面量（String literals）
// 声明字符串使用""表示，不需要@
// 这里由于进行了初始化，可以自动完成类型推断为String类型
let aString = "This is a normal string"

// 2、创建空字符串
// 创建空的字符串有多种方式，可以将一个""表示空字符串，也可以用构造函数为空串
var emptyString = ""
var anEmptyString = String()
// 这两个都是一样的，都为空字符串，是等价的
if emptyString.isEmpty && anEmptyString.isEmpty {
  print("都是空字符串，是等价的")
}

// 3、字符串可变性
// 在Swift中通过用let声明字符串不可变，用var声明字符串可变；对于objective-c中，
// 用NSString声明不可变，用NSMutableString声明可变字符串
let immutableString = "Could\'t not change any more"
var mutableString = "Later can change string value"
mutableString += ", this is the changable string value"
print(mutableString)

// 4、字符串是值类型
/*
   Swift 的String类型是值类型。 创建了一个新的字符串，那么当其进行常量、变量赋值操作，
   或在函数/方法中传递时，会进行值拷贝。 任何情况下，都会对已有字符串值创建新副本，并对
   该新副本进行传递或赋值操作。但是在Objective-C中的NSString类型是引用类型。
*/
func printString(StringShort: String) {
//  StringShort = "常量不能修改"
  print(StringShort)
}
printString("Here I am")
printString(mutableString)

// 5、如何访问字符
// 在实际编译时，Swift 编译器会优化字符串的使用，使实际的复制只发生在绝对必要的情况下，
// 这意味着您将字符串作为值类型的同时可以获得极高的性能。
// for-in
for character in "这是Dog🐶吗~".characters {
  print(character)
}

// 6、创建字符
// 用Character声明字符，且只能是一个字符
let c: Character = "!"
// Error
//let cc: Character = "!!"
print(c)

// 7、字符串连接
// 字符串连接可以用+将两个字符串连接起来
let s1 = "Hello"
let s2 = "my name is Jacky Huang"
var greeting = s1 + s2
print(greeting)

// 用+=追加
var desc = "Hello, "
desc += "My name is Jacky Huang"
print(desc)

// 用append追加，但是只能追加一个字符
desc = "Hello"
// 必须指定类型为Character，否则会自动推断成String
let ccc: Character = "!"
//desc.append("!");
// 必须是明确指定为Character类型
desc.append(ccc)
print(desc)

// 8、字符串插值
// 字符串插值是一种构建新字符串的方式，可以在其中包含常量、变量、字面量和表达式。
// 您插入的字符串字面量的每一项都在以反斜线为前缀的圆括号中：
let multiplier = 3
let message = "\(multiplier) is the result value"
print(message)

// 9、获取字符串的长度
// 使用characters.count属性获取
let aStr = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("aStr's length = \(aStr.characters.count)")

// 10、访问字符串
/*
通过调用String.Index的predecessor()方法，可以立即得到前面一个索引，
调用successor()方法可以立即得到后面一个索引。任何一个String的索引都
可以通过锁链作用的这些方法来获取另一个索引，也可以调用advancedBy(_:)
方法来获取。但如果尝试获取出界的字符串索引，就会抛出一个运行时错误。
你可以使用下标语法来访问String特定索引的Character。
个人认为这种方式来访问字符串，容易出事，尽量少用
*/
let ask = "Gun dan"
ask[ask.startIndex]
// 这么写是错误的，endIndex表示最后一个位置的索引，但是它不是有效的索引
//ask[ask.endIndex]
// 但是可以通过predecessor获取得到最后一个字符
ask[ask.endIndex.predecessor()]
// 获取第一个字符的前一个，越界了，所以是Error
//ask[ask.startIndex.predecessor()]
// 获取第一个字符中下一个字符
ask[ask.startIndex.successor()]

// 获取索引
// ask.startIndex.advancedBy 2.0版本的Swift中没有advancedBy API了
//let indexOfSev = ask.startIndex.advancedBy(3)

// 通过索引范围遍历
for index in ask.characters.indices {
  print("\(ask[index]) is ask's index: \(index)")
}

// 11、插入、删除字符
// 插入字符
var welcome = "Hello world"
welcome.insert("!", atIndex: welcome.endIndex)
print(welcome)
// insertContentsOf已经在2.0中去掉了

// 移除字符
welcome.removeAtIndex(welcome.endIndex.predecessor())
print(welcome)

// 移除一个范围内的字符
welcome.removeRange(Range(start: welcome.startIndex.successor(),
  end: welcome.endIndex))
print(welcome)// H

welcome = "Hello world"
// 全部移除
welcome.removeAll()
print(welcome)

// 12、比较字符串
// Swift 提供了三种方式来比较文本值：字符串字符相等、前缀相等和后缀相等。
//
// 判断字符串字符相等
let string1 = "This is string1"
let string2 = "This is string2"
if string1 == string2 {
  print("string1 == string2")
} else {
  print("string1 != string2")
}
// 判断前缀是否相等
if string1.hasPrefix("This") {
  print("string1 has prefix: This")
} else {
  print("string1 doesn\'t have prefix: This")
}
// 判断后缀是否相同
if string1.hasSuffix("1") {
  print("ok, has suffix 1")
}






