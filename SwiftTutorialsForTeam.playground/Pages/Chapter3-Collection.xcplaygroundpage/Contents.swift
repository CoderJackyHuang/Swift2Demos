//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

// 第三节：集合类型

// 1、数组
// Array是结构体，数组属性值类型，与Objective-C中的NSArray/NSMutableArray无缝桥接
var intValues = [Int]() // 空数组
var intValues1: [Int] = [] // 空数组
var intValues2 = Array<Int>() // 空数组 
var intValues3: Array<Int> = [] // 空数组
intValues1.append(1)
intValues2.append(2)
intValues3.append(3)

// 当使用类型推断时，类型不一致并没有关系，实际上Array是泛型
// 这实际上是由于类型推断出有String类型和Int类型，所以可推断出其父级类型为NSObject
var intv = "10"
var strValues = ["谢谢", "哈哈", 10]
print(strValues.last!)
print(strValues[2])
//intv = strValues[1] as? String

// 2、追加元素
// intValues4元素类型为Int
let intValues4 = intValues1 + intValues2

// 两个类型不一致不能连接
//let values = intValues2 + strValues

intValues2.append(3)// 追加
intValues2.insert(4, atIndex: 0) // 插入

// 3、遍历
// for-in
for item in intValues4 {
  print(item)
}

let values = ["测试", "循环", "遍历"]
// 使用enumerate方法
for (index, value) in values.enumerate() {
  print("\(index)=>\(value)")
}

// 4、集合
// 集合的使用与Array的使用非常相似
let set = Set<Character>()// 空集

let fav: Set<String> = ["A", "B", "C"]
var fav1: [String] = ["1", "11"]
var intVV = 10
intVV = Int(fav1[0])!


// 遍历
for item in fav {
  print(item)
}

// <也是一个函数，ASC
for item in fav.sort(<) {
  print(item)
}

// 5、字典
//[keyType: ValueType]
var dict = [Int: AnyObject]()// 空字典
dict[0] = "Apple"
if let item = dict.updateValue("AppleDev", forKey: 0) {
  print(item)
}
print(dict[0])

// 移除
if let removedItem = dict.removeValueForKey(0) {
  print(removedItem)
}

dict[0] = "Apple"
dict[1] = "Orange"
dict.updateValue("Green", forKey: 2)// 如果没有，则添加

// 遍历
for (key, value) in dict {
  print("\(key) => \(value)")
}

for key in dict.keys {
  print(key)
}

for value in dict.values {
  print(value)
}


