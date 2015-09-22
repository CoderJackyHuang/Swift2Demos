//: [Previous](@previous)

import Foundation

// 第十节：内存管理

// 解决循环引用问题
class Person {
  let name: String
  // 不是人人都有公寓的
  var apartment: Apartment?
  // 不是人人都会有车的，因此使用可选类型
  var car: Car?
  
  init(name: String) {
    self.name = name
  }
  
  deinit {
    print("\(name) deinit")
  }
}

class Apartment {
  let number: Int
  // 租户，使用弱引用，来解决循环引用不能释放的问题
  weak var tenant: Person?
  
  init(number: Int) {
    self.number = number
  }
  
  deinit {
    print("Apartment deinit")
  }
}

class Car {
  let number: Int
  
  // 无主引用类型，总是有值的，不能声明为可行类型
  unowned var owner: Person
  
  // 由于永远都要有值，因此必须通过构造函数来赋值
  init(number: Int, owner: Person) {
    self.number = number
    self.owner = owner
  }
  
  deinit {
    print("car deinit")
  }
}

var jacky: Person? = Person(name: "Jacky")
var goldHouseApartment: Apartment? = Apartment(number: 2)
// 将车与jacky关联起来了
var daizhongCar: Car? = Car(number: 2, owner: jacky!)

jacky!.apartment = goldHouseApartment
goldHouseApartment!.tenant = jacky

jacky = nil
goldHouseApartment = nil
daizhongCar = nil


// 总结：
// 一两个都可空，通常使用weak
// 一个可空，另一个不可空，通常用unowned