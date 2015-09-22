//: [Previous](@previous)

import Foundation

// 第九节：类

// 用于抛出异常的枚举，必须遵守ErrorType协议
enum AudioPlayerErrorType: ErrorType {
  case URLEmpty
  case URLError
  case LoadResourceFail
}

class AudioPlayer: NSObject {
  var isPlaying = false
  var canPlay = false
  var url: String?
  
  override init() {
    self.url = nil
    
    super.init()
  }
  
  func prepareToPlay() throws {
    // 若正在播放，则不处理
    guard isPlaying != true else {
      return
    }
    
    guard let resourseUrl = url else {
      throw AudioPlayerErrorType.URLEmpty
    }
    
    guard let resUrl = NSURL(string: resourseUrl) else {
      throw AudioPlayerErrorType.URLError
    }
    
    guard loadWithUrl(resUrl) else {
      throw AudioPlayerErrorType.LoadResourceFail
    }
    
    canPlay = true
  }
  
  func loadWithUrl(url: NSURL) ->Bool {
    return true
  }
  
  func play() throws {
    try prepareToPlay()
    print("playing")
    isPlaying = true
  }
}

func playSong() {
  let player = AudioPlayer()
  
  do {
    try player.play()
    print("playing songs.")
  } catch AudioPlayerErrorType.URLEmpty {
    print("url empty")// 捕获到异常并处理了
  } catch AudioPlayerErrorType.URLError {
    print("url error")
  } catch {
    print("load resource fail")
  }
  
  defer {
    // 不管有没有错误发生，都可以执行一些必要的收尾操作。
    // 包括关闭打开的文件描述符以及释放所有手动分配的内存。
    // 与c#中的finally类似的用法
    print("do it")
  }
}

playSong()

// try!方式是告诉编译器，不可能有异常，不需要处理。
// 如果用try!，但是又抛出了异常，则会crash
func playSongAgain() {
  let player = AudioPlayer()
//  try! player.play() // crash
  
  defer {
    // 不管有没有错误发生，都可以执行一些必要的收尾操作。
    // 包括关闭打开的文件描述符以及释放所有手动分配的内存。
    // 与c#中的finally类似的用法
//    print("不会打印，因为crash了")
  }
}
playSongAgain()


// 1、构造函数
// 注意：designed init类型的构造器只能调用designed init类型的构造器，
// 不能调用convenience init类型的构造器。而convenience init类型的构造器
// 可以调用convenience init类型的构造器，或者直接调用designed init类型的构造器
class Vehicle: NSObject {
  var passengers: Int
  var wheels: Int
  var maxPassengers: Int
  // 不允许重写
  final var color: Int
  
  // 重写NSObject的init
  override init() {
    // 初始化我们要做的事
    passengers = 0
    wheels = 0
    color = 0
    maxPassengers = 20
    
    // 再调用父类的，顺序不能相反
    super.init()
  }
  
  init(maxPassengers: Int = 2, wheels: Int = 2) {
    self.wheels = wheels
    self.maxPassengers = maxPassengers
    passengers = 0
    color = 0
    
    super.init()
  }
  
  init(passengers: Int, maxPassengers: Int, wheels: Int, color: Int) {
    self.passengers = passengers
    self.maxPassengers = maxPassengers
    self.wheels = wheels
    self.color = color
    
    super.init()
  }
  
  // 使用convenience来声明的方便构造器，必须要调用本类定义的构造器
  convenience init(passengers: Int, wheels: Int) {
    self.init(maxPassengers: 20, wheels: 2)// 不是super.init
    
    // 再初始化我们的
    self.passengers = passengers
  }
  
  // convenience构造器之间是可以互调的，但是至少要有一个convenience构造器直接
  // 调用了本类的designated构造器
  convenience init(passengers: Int, wheels: Int, color: Int) {
    self.init(passengers: passengers, wheels: wheels)
    
    self.color = color
  }
  
  func showDescription() {
    print("passgeners=\(passengers), wheels = \(wheels), color = \(color)")
  }
}

// 定义一个单车类
class Bicycle: Vehicle {
  // 常量属性只能通过初始值设置或者通过构造器设置值
  var constant: Int
  
  // 属性观察器
  override var passengers: Int {
    didSet {
      print("passengers new value is \(self.passengers)")
    }
    
    willSet {
      print("passengers new value will be set to be \(self.passengers)")
    }
  }
  
  init(passengers: Int, wheels: Int, constant: Int) {
    self.constant = constant

    super.init(passengers: passengers, maxPassengers: 2, wheels: wheels, color: 0)
  }
  
  // 可以重写父类的convenience构造器
  override convenience init(passengers: Int, maxPassengers: Int, wheels: Int, color: Int) {
    self.init(passengers: passengers, wheels: wheels, constant: 0)
    
    self.maxPassengers = 2
    self.color = 0
  }
  
  // 可失败构造器
  init?(passengers: Int, maxPassengers: Int) {
    self.constant = 0
    super.init(passengers: passengers, maxPassengers: maxPassengers, wheels: 2, color: 2)
    
    if maxPassengers < passengers {
      self.maxPassengers = 20
      self.passengers = 2
      return nil // 可失败构造器，通过返回nil表示
    }
  }
  
  required override init() {
    fatalError("子类必须重写")
  }
  
  // 重写方法
  override func showDescription() {
    print("passgeners=\(passengers), wheels = \(wheels), color = \(color)")
  }
}

let bicycle = Bicycle(passengers: 2, wheels: 2, constant: 2)
bicycle.showDescription()

print(bicycle.passengers)
print(bicycle.wheels)

let b = Bicycle(passengers: 2, maxPassengers: 2, wheels: 2, color: 2)
print(b.passengers)
print(b.maxPassengers)
print(b.wheels)
print(b.color)

// bb = nil
let bb = Bicycle(passengers: 2, maxPassengers: 1)
print(bb?.passengers)
print(bb?.maxPassengers)

