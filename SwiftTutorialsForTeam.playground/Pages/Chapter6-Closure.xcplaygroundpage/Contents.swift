//: [Previous](@previous)

import Foundation

// 第六节：闭包
/*
在函数 章节中介绍的全局和嵌套函数实际上也是特殊的闭包，闭包采取如下三种形式之一：

全局函数是一个有名字但不会捕获任何值的闭包
嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包
Swift 的闭包表达式拥有简洁的风格，并鼓励在常见场景中进行语法优化，主要优化如下：

利用上下文推断参数和返回值类型
隐式返回单表达式闭包，即单表达式闭包可以省略return关键字
参数名称缩写
尾随（Trailing）闭包语法

闭包表达式语法（Closure Expression Syntax）
{ (parameters) -> returnType in
  statements
}
*/

let names = ["peter", "smith"]
let reversedNames = names.sort { (name1, name2) -> Bool in
  return name1 > name2// 使用>或者<或者=的前提是该类型有>、<、=函数
}
print(reversedNames)

// 对于简单的闭包，可以省略参数，return等
names.sort { (e, f) -> Bool in
  e > f
}

// 再简化一步
names.sort {
  $0 > $1
}

// 再简化
names.sort(>)


