//: [Previous](@previous)

import Foundation

// MARK: 学习Swift中的单例写法
// 在Swift开发中，我们一定会遇到实现单例的问题，那么有哪些单例的写法呢？我们应该使用哪种方式呢？
// 让我们一起来探讨吧！

// 1、非线程安全的类属性嵌套方式
//class JackyBlog {
//  // 类属性使用class声明，声明为只读属性
//  class var sharedInstance: JackyBlog {
//    get {
//      // 嵌套一个结构体
//      struct JackyBlogSingleton {
//        static var singleton: JackyBlog?
//      }
//      
//      guard JackyBlogSingleton.singleton == nil else {
//        return JackyBlogSingleton.singleton!
//      }
//      
//      JackyBlogSingleton.singleton = JackyBlog()
//      
//      return JackyBlogSingleton.singleton!
//    }
//  }
//}

// 2、线程安全的类属性嵌套方式
//class JackyBlog {
//  // 类属性使用class声明，声明为只读属性
//  class var sharedInstance: JackyBlog {
//    get {
//      // 嵌套一个结构体
//      struct JackyBlogSingleton {
//        static var singleton: JackyBlog? = nil
//        static var onceToken: dispatch_once_t = 0
//      }
//      
//      guard JackyBlogSingleton.singleton == nil else {
//        return JackyBlogSingleton.singleton!
//      }
//      
//      // 加上线程安全处理
//      dispatch_once(&JackyBlogSingleton.onceToken) { () -> Void in
//        JackyBlogSingleton.singleton = JackyBlog()
//      }
//      
//      return JackyBlogSingleton.singleton!
//    }
//  }
//}

// 3、全局常量模式（不建议使用这种）
//let g_singletonSharedInstance = JackyBlog()
//class JackyBlog {
//  class var sharedInstance: JackyBlog {
//    return g_singletonSharedInstance
//  }
//}

//// 4、静态常量模式（线程安全，这种更简洁,swift1.2之后才支持这种写法）
//class JackyBlog {
//  // 表态，使用let声明是纯种安全的
//  static let sharedInstance = JackyBlog()
//}
//
// 5、使用类方式模式（这是跟系统的方法的一致）
// NSFileManager.defaultManager(), NSNotificationCenter.defaultCenter(),
// 都是通过类方法的模式，因此强烈推荐这种写法
// 线程安全
class JackyBlog {
  class func sharedInstance() ->JackyBlog {
    struct Singleton {
      static var onceToken: dispatch_once_t = 0
      static var singleton: JackyBlog? = nil
    }
    
    dispatch_once(&Singleton.onceToken) { () -> Void in
      Singleton.singleton = JackyBlog()
    }
    
    return Singleton.singleton!
  }
}
