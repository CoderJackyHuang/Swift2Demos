//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

/*
##环境
```
//: 环境：xcode7 beta6
//: swift2.0 String记录
```
*/

/*
##集合类型介绍
Swift中提供了Array、Set、Dictionary三种集合类型，Array是有序数组，
Set是无序无重复集合，Dictionary是无序的键值对集合。
这三种类型中的元素的类型必须是一致的。
> 注意：Swift中Array、Set、Dictionary都是泛型类型，要求明确指定类型。
 Swift 的Array类型被桥接到Foundation中的NSArray类。
*/


// ##1、集合的可变性
// 在swift中要让Array、Set、Dictionary类型的变量是可变的，用var声明就可以了。
// 如果不希望可变，用let声明即可。
let immutableArrray = [Int]()
// 提示：error: immutable value of type '[Int]' only has mutating
// members named 'append'
//immutableArrray.append(12)
var mutableArray = [Int]()
mutableArray.append(12)

// ##2、创建空数组(Array)
// 数组使用有序列表存储同一类型的多个值。相同的值可以多次出现在一个数组的不同位置中。
// 使用构造语法来创建一个由特定数据类型构成的空数组：
// 方括号中必须指定类型，因为Array是一种泛型
var emptyArray = [Int]()
// 也可以使用结构体Array的构造写法
var anotherEmptyArray = Array<Int>()
emptyArray.append(12)
// 如果之前类型明确了，直接再用[]即可.一样是Int类型的元素，是可推断出来的
emptyArray = []
emptyArray.append(121)

// ##3、创建带默认值的数组
var threeInts = [1, 2, 3]
// 或者用构造方法
threeInts = [Int](count: 3, repeatedValue: 10)
// 或者
var anotherThreeInts = Array<Int>(count: 3, repeatedValue: 5)
// 如果将两个类型相同的数组直接用+连接，形成一个新的数组
var componentArray = threeInts + anotherThreeInts
// 可以指定类型
var specifyTypeArray: [String] = ["Milk", "Egg"]
// 不能这么写，编译不能通过
//var specifyTypeArray1: Array<String>() = ["Milks", "Eggs"]
// 类型要求相同，否则编译不能通过
//var diffTypeArray: [String] = [1, "str"]

// ##4、访问和修改数组
var array = [1, 4, 5, 2, 4]
// 获取元素的个数 
print("The element count of array is \(array.count)")
// 判断是否为空数组，可用方法isEmpty或者判断count是否为0
if array.count == 0 {
  print("empty")
} else {
  print("non empty")
}
if array.isEmpty {
  print("empty")
} else {
  print("non empty")
}

// 追加元素，可以用+=、append
array.append(6)
print(array)

array += [6, 6, 6]
print(array)

// 获取元素，可以通过索引获取
var item = array[0]

// 修改元素值，可以通过索引
array[0] = 100
// 可以修改指定范围的值
array[1..<4] = [77, 88, 99]

// 插入新元素
array.insert(55, atIndex: 3)
print(array.count)

// 移除元素
// 删除第一个
array.removeAtIndex(0)
// 删除最后一个
item = array.removeLast()
// 删除所有元素，但是内存不释放，空间容量保留
array.removeAll(keepCapacity: true)

// 遍历访问数组
for item in array {
  print(item)
}
// 如果需要同时获取索引和值，通过这种方式遍历
for (index, value) in array.enumerate() {
  print("index: \(index), value = \(value)")
}

// ##5、集合
/* 集合(Set)用来存储相同类型并且没有确定顺序的值。当集合元素顺序不重要时 或者希望确保每个元素只出现一次时可以把集合当做是数组另一形式。
> 为了存储在集合中，该类型必须是可哈希化的-也就是说，该类型必须提供一个方法来计算它的哈希值。一个哈希值是Int类型的，它和其他的对象相同，其被用来比较相等与否，比如a==b,它遵循的是a.hashValue == b.hashValue。Swift 的所有基本类型(比如String,Int,Double和Bool)默认都是可哈希化的，它可以作为集合的值或者字典的键值类型。没有关联值的枚举成员值(在枚举有讲述)默认也是可哈希化的。
> 注意： 使用自定义的类型作为集合的值或者是字典的键值类型时，需要使自定义类型服从Swift标准库中的Hashable协议。服从Hashable协议的类型需要提供一个类型为Int的取值访问器属性hashValue。这个由类型的hashValue返回的值不需要在同一程序的不同执行周期或者不同程序之间保持相同。 因为hashable协议服从于Equatable协议，所以遵循该协议的类型也必须提供一个"是否等"运算符(==)的实现。这个Equatable协议需要任何遵循的==的实现都是一种相等的关系。也就是说，对于a,b,c三个值来说，==的实现必须满足下面三种情况

* a==a(自反性)
* a==b意味着b==a(对称性)
* a==b&&b==c意味着a==c(传递性)
*/

// ## 6、创建集合
var emptySet = Set<Int>()
print(emptySet.count) // 0

emptySet.insert(12)
// 当变量已经有明确的类型时，再用空数组来初始化[]，其类型也是可推断的
emptySet = []// 类型为Set<Int>()

// 用数组构造集合
var favSet: Set<String> = ["milk", "egg"]
// 如果元素都是相同类型，带有初始化，可以省略类型
var favSet1: Set = ["good milk", "bad egg"]

// ## 7、访问和修改set
// 判断是否为空集
if favSet.isEmpty {
  print("empty set")
} else {
  print("non empty set")
}

// 插入一个元素
favSet.insert("wahaha") // 4个元素

// 移除一个元素
if let removedElement = favSet.remove("wahaha") {
  print("移除成功")
} else {
  print("移除失败")
}

// 判断是否包含元素
if favSet.contains("wahaha") {
  print("fav set contains wahaha")
} else {
  print("fav set doesn\'t not contain wahaha")
}

// 遍历一个set。使用for-in
for value in favSet {
  print(value)// 这是无序的
}

// 要使之有序
// sort方法
for value in favSet.sort({ (e, ee) -> Bool in
  return e > ee // 由我们指定排序类型desc（降序）
}) {
  // milk
  // egg
  print(value)
}

// 或者直接使用sort无参数（默认为asc升序）
for value in favSet.sort() {
  // egg
  // milk
  print(value)
}


// ## 7、集合操作
/* 集合常用的操作有：(intersect)交集、（union）并集、subtract（去掉交集）、exclusiveOr（去掉交集后的并集）
* 使用intersect(_:)方法将a、b集合中的公共部分生成一个新的集合
* 使用exclusiveOr(_:)方法将a和b集合中共同的部分去掉，再将剩余的a、b元素合并成新的集合。
* 使用union(_:)方法将a、b两个集合合并并去掉相同的元素，生成新的集合。
* 使用subtract(_:)方法将a集合中在b集中中的部分去掉，返回a剩余的元素，生成一个新集合。
*/
let set1: Set = [1, 2, 3, 4, 5]
let set2: Set = [1, 4, 3, 8]
// 3, 1, 4
print(set1.intersect(set2))

// 1, 2, 3, 4, 5
print(set1.union(set2).sort())

// 2, 5
print(set1.subtract(set2).sort())

// 2, 5, 8
print(set1.exclusiveOr(set2).sort())

/*使用“是否等”运算符(==)来判断两个集合是否包含全部相同的值。
* 使用isSubsetOf(_:)方法来判断是否为子集。
* 使用isSupersetOf(_:)方法来判断是否为超集，即a包含b中的全部元素。
* 使用isStrictSubsetOf(_:)或者isStrictSupersetOf(_:)方法来判断一个集合是否是另外一个集合的子集合或者父集合，但是两个集合不相等。
使用isDisjointWith(_:)方法来判断两个集合是否不含有相同的值。
*/
// false
print(set1.isSubsetOf(set2))
let set3: Set = [1, 2, 5]
// true
print(set3.isSubsetOf(set1))
// true
print(set1.isSupersetOf(set3))
// true，set1是set3的严格超集，因为Set1包含Set3的全部元素且set1 != set3
print(set1.isStrictSupersetOf(set3))
// true
print(set3.isStrictSubsetOf(set1))

let set4: Set = [1, 5, 2]
// false,因为set3和set4的元素是一样的，即相等
print(set4.isStrictSubsetOf(set3))

// false，这两个集合中有相同的元素
print(set3.isDisjointWith(set4))
let set5:Set = [9, 6]
// true,set5和set4没有相同的元素
print(set5.isDisjointWith(set4))


// ##8、字典
/*
字典是一种存储多个相同类型的值的容器。每个值（value）都关联唯一的键（key），键作为字典中的这个值数据的标识符。和数组中的数据项不同，字典中的数据项并没有具体顺序。我们在需要通过标识符（键）访问数据的时候使用字典，这种方法很大程度上和我们在现实世界中使用字典查字义的方法一样。
> 注意： Swiftly 的Dictionary 类型被桥接到Foundation的NSDictionary类

Swift 的字典使用Dictionary<Key, Value>定义，其中Key是字典中键的数据类型，Value是字典中对应于这些键所存储值的数据类型。我们也可以用[Key: Value]这样快捷的形式去创建一个字典类型。虽然这俩种形式功能上相同，但是后者是首选，并且这本指导书涉及到字典类型时通篇采用后者。
> 注意： 一个字典的Key类型必须遵循Hashable协议，和Set的值类型一样的要求。
*/

// ##9、创建字典
// 创建空字典
var emptyDict = [Int: String]()
// 或者
emptyDict = Dictionary<Int, String>()
// 当创建过emptyDict后，再用[:]又成为一个空字典
emptyDict = [:]

// 多个键值对用逗号分割
// 通过类型推断是可以推断出来类型为[String: String]
var dict = ["A": "Apple", "B": "Bubble"]

// 如果不希望字典可变，用let声明即可
let immutableDict = ["A": "Apple", "B": "Bubble"]
// 无法调用，因为是不可变的
//immutableDict.updateValue("App", forKey: "A")
//immutableDict += ["AB:", "Apple Bubble"]

// 判断是否为空字典
if dict.isEmpty {
  print("dict is an empty dictionary")
} else {
  print("dict is not an empty dictionary")
}

// 或者通过count==0
if dict.count == 0 {
  print("dict is an empty dictionary")
} else {
  print("dict is not an empty dictionary")
}

// ##10、读取、修改字典
var apple = dict["A"]
// 修改，如果不存在，则会增加，否则更新值
dict["A"] = "Good Apple"
apple = dict["A"]
// 或者用API，如果不存在，则会增加，否则只是更新值
dict.updateValue("Good Apple is very sweet", forKey: "A")
print(dict)

if let oldValue = dict.updateValue("Dog", forKey: "D") {
  print("The old value is \(oldValue)")
} else {
  // 输出这行
  print("The key D does\'t not exist before update")
}

// 读取时，判断是否有值
if let value = dict["BB"] {
  print("value is \(value)")
} else {
  // 输入这行
  print("The key BB doesn\'t not exist in dict")
}

// 移除
dict["D"] = nil
// 或者
if let removedValue = dict.removeValueForKey("D") {
  print("The removed value is \(removedValue)")
} else {
  print("The key D doesn'\t exist in dict, can\' be removed.")
}

// ##11、遍历字典
// 用for-in遍历，形式为(key, value)
for (key, value) in dict {
  print("\(key): \(value)")
}

// 可以遍历key
for key in dict.keys {
  print("\(key): \(dict[key])")
}

for value in dict.values {
  print("\(value)")
}





