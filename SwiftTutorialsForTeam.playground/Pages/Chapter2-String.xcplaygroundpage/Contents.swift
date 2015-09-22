//: [Previous](@previous)

import Foundation

// 第二节：字符串和字符

// 1、字符串和字符都是使用双引号
var string = "" // 空字符串
string = String() // 空字符串
string = String("")// 空字符串
var c: Character = "A"


// 2、字符串是值类型
// 字符串是结构体类型，而结构体是值类型，因此字符串也是值类型。在传值时，会进行值拷贝而不是引用。
string = "值拷贝"
func testStringCopy(var str: String) {
  str = "这里新值"
  print(str)
}
testStringCopy(string) // 这里新值
print(string) // 值拷贝

// 3、字符串连接
// 有以下几种方式：
var str = "字符串连接"
str += string // str=字符串连接值拷贝,string=值拷贝
// 使用\(变量、常量、函数返回值等)
str = "\(str)\(string)"
// 注意，由于"A"这么写编译器无法识别是字符还是字符串，
// 且append只能追加一个字符，不能追加字符串
//str.append("A")// 提示：mutating func append(c: Character)
str.append(Character("A"))// 传类型强转换就可以了

class User {
  var name: String = ""
}

let user = User()
user.name = "123"
func update(user: User) {
  user.name = "ABC"
}

update(user)
print(user.name)



// 4、获取字符串长度
// 正确获取长度的方式：
let len = str.characters.count

// 5、字符串比较
// 判断是否相等，可以用两个等号==，不相等就用!=
if str != "谢谢" {
  print("不相等")
}
if "谢谢" == "谢谢" {
  print("肯定相等")
}
// 判断前缀、后缀是否相等
if str.hasPrefix("字符串") {
  print("有...")
}
if str.hasSuffix("连接") {
  print("有...")
}
