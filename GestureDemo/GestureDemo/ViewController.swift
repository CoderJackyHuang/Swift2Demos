//
//  ViewController.swift
//  GestureDemo
//
//  Created by huangyibiao on 15/9/11.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import UIKit

/// 学习Swift中的几种手势
/// 环境：xcode7-beta6
/// 语言：swift2.0
class ViewController: UIViewController {
/// 注意：可能会有朋友觉得声明为变量是多余的，确实是正确的。
///      这里声明为变量，只是为了添加注释，说明有哪些手势。

// 单指点击手势
var tapGesture: UITapGestureRecognizer!
// 长按手势
var longGesture: UILongPressGestureRecognizer!
// 左、右、上、下划手势
var swipeGestuer: UISwipeGestureRecognizer!
// 拖手势（IOS7的右滑返回手势就是pan手势）
var panGesture: UIPanGestureRecognizer!
// 捏手势
var pinGesture: UIPinchGestureRecognizer!
// 旋转手势
var rotateGesture: UIRotationGestureRecognizer!
// 图片控件
var imageView: UIImageView!
var tipLabel: UILabel!

override func viewDidLoad() {
  super.viewDidLoad()
  
  self.tipLabel = UILabel(frame: CGRectMake(10, 20, 300, 100))
  self.tipLabel.backgroundColor = UIColor.whiteColor()
  self.tipLabel.textAlignment = NSTextAlignment.Center
  self.tipLabel.textColor = UIColor.redColor()
  self.tipLabel.text = "一起来学习Swift中的手势吧！"
  self.view .addSubview(self.tipLabel)
  
  // 创建图片控件
  self.imageView = UIImageView()
  self.imageView.frame = CGRectMake(0, 0, 250, 250)
  self.imageView.center = self.view.center
  // 一定要开启可交互
  self.imageView.userInteractionEnabled = true;
  self.view.addSubview(self.imageView)
  let imagePath: String? = NSBundle.mainBundle().pathForResource("black", ofType: "jpg")
  if let name = imagePath {
    self.imageView.image = UIImage(named: name)
  } else {
    print("image not found")
  }
  
  // MARK: 在这里开启测试入口
  let testType = 6
  let swipeDirection = 2 // 1-left,2-right,3-up,4-down
  testEntrance(testType, swipeDirection);
}

// 测试入口
private func testEntrance(testType: Int = 1, _ swipeDirection: Int = 1) {
  switch testType {
  case 1:
    // 1、常用的点击手势
    self.tapGesture = UITapGestureRecognizer(target: self,
      action: "onTapGesture:")
    // 默认就为1，点一次就触发
    // 实际使用中，基本不会去设置这个属性
    self.tapGesture.numberOfTapsRequired = 1
    // 默认为1，需要多少个手势点击才能触发
    // 实际使用中，基本不会去设置这个属性，几乎都是单指点击
    self.tapGesture.numberOfTouchesRequired = 1
    self.imageView.addGestureRecognizer(self.tapGesture)
  case 2:
    // 2、常用的长按手势
    self.longGesture = UILongPressGestureRecognizer(target: self,
      action: "onLongPressGesture:")
    // 长按时长为多少秒才会触发，默认为0.5，在实际应用中用默认值即可
    self.longGesture.minimumPressDuration = 0.5
    // 在长按手势失败前允许最大移动像素，默认为10，在实际应用中用默认值即可
    self.longGesture.allowableMovement = 10
    self.imageView.addGestureRecognizer(self.longGesture)
  case 3:
    // 3、划手势
    self.swipeGestuer = UISwipeGestureRecognizer(target: self,
      action: "onSwipeGesture:")
    // 要求触摸的次数，默认为1，使用默认值即可
    self.swipeGestuer.numberOfTouchesRequired = 1
    self.imageView.addGestureRecognizer(self.swipeGestuer)
    // 测试四种方向：左、右、上、下
    // UISwipeGestureRecognizerDirection不是enum类型，不能直接使用.Left
    switch swipeDirection {
    case 1:
      self.swipeGestuer.direction = UISwipeGestureRecognizerDirection.Left
    case 2:
      self.swipeGestuer.direction = UISwipeGestureRecognizerDirection.Right
    case 3:
      self.swipeGestuer.direction = UISwipeGestureRecognizerDirection.Up
    default:
      self.swipeGestuer.direction = UISwipeGestureRecognizerDirection.Down
    }
  case 4:
    self.panGesture = UIPanGestureRecognizer(target: self, action: "onPanGesture:")
    // 触发条件中的最小触摸次数，默认为1，实际中使用默认值即可
    self.panGesture.minimumNumberOfTouches = 1
    // 触发条件中的最大触摸次数，默认为UINT_MAX，也就是Int.max，
    // 在实际使用中使用默认值即可
    self.panGesture.maximumNumberOfTouches = Int.max
    self.imageView.addGestureRecognizer(self.panGesture)
  case 5:
    self.pinGesture = UIPinchGestureRecognizer(target: self,
      action: "onPinGesture:")
    self.imageView.addGestureRecognizer(self.pinGesture)
  case 6:
    self.rotateGesture = UIRotationGestureRecognizer(target: self,
      action: "onRotateGesture:")
    self.imageView.addGestureRecognizer(self.rotateGesture)
  default:
    print("error type")
  }
}

// 1、常用的点击手势回调
func onTapGesture(sender: UITapGestureRecognizer) {
  // Swift中检测API是否可用，使用#available(iOS x, OSX x, *)
  // 若只判断iOS的，可以使用#available(iOS x, *)
  // 其中*表示任意平台可用
  if #available(iOS 8.0, *) {
    // 我们发现使用这新版的alert好麻烦，因此我们需要对这种代码进
    // 一步封装，才能在项目中使用
    // 这里暂不封装，下一步我们再处理一下
    let alert = UIAlertController(title: "提示",
      message: "测试了UILongPressGestureRecognizer长按手势",
      preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "确定",
      style: .Default,
      handler: { (acton) -> Void in
        
    }));
    self.presentViewController(alert, animated: true, completion: nil)
  } else {
    UIAlertView(title: "提示",
      message: "测试了UITapGestureRecognizer点击手势",
      delegate: nil,
      cancelButtonTitle: "确定").show()
  }
}

// 2、常用的长按手势
func onLongPressGesture(sender: UILongPressGestureRecognizer) {
  // 防止多次点击回调
  // 使用了guard来守护，只有为sender.enabled=true的条件下，才能通过
  guard sender.enabled else {
    print("不能重复显示")
    return
  }
  
  sender.enabled = false
  self.showAlert("提示",
    message: "测试了UILongPressGestureRecognizer长按手势",
    okTitle: "确定") { () -> Void in
      print("点击了确定")
      sender.enabled = true
  }
}

// 3、划动手势
func onSwipeGesture(sender: UISwipeGestureRecognizer) {
  // 注意：这里的UISwipeGestureRecognizerDirection不是枚举类型，
  // 不能直接使用省略类型，而直接用.Left
  switch sender.direction {
  case UISwipeGestureRecognizerDirection.Left:
    print("swipe direction is left")
  case UISwipeGestureRecognizerDirection.Right:
    print("swipe direction is right")
  case UISwipeGestureRecognizerDirection.Up:
    print("swipe direction is up")
  default:
    print("swipe direction is down")
  }
}

// 4、拖动手势
func onPanGesture(sender: UIPanGestureRecognizer) {
  // 获取被拖动的坐标
  let translation = sender.translationInView(self.imageView)
  // 将图片平移
  self.imageView.transform = CGAffineTransformMakeTranslation(
    self.imageView.transform.tx + translation.x,
    self.imageView.transform.ty + translation.y)
  
  // 松手，手势结束了
  if sender.state == UIGestureRecognizerState.Ended {
    // 还原到原始位置
    self.imageView.transform = CGAffineTransformIdentity
  }
}

// 5、捏手势
func onPinGesture(sender: UIPinchGestureRecognizer) {
  // 取得当前的绽放比例
  let scale = sender.scale

  self.imageView.transform = CGAffineTransformMakeScale(
    self.imageView.transform.tx + scale,
    self.imageView.transform.ty + scale)
  
  // 还原大小
  if sender.state == UIGestureRecognizerState.Ended {
   UIView.animateWithDuration(0.25, animations: { () -> Void in
     self.imageView.transform = CGAffineTransformIdentity
   })
  }
}

// 6、旋转手势
func onRotateGesture(sender: UIRotationGestureRecognizer) {
  // 取得当前的旋转值
  let rotation = sender.rotation
  
  self.imageView.transform = CGAffineTransformMakeRotation(rotation)
  
  // 旋转松手后，还原为初始状态
  if sender.state == UIGestureRecognizerState.Ended {
    UIView.animateWithDuration(0.25, animations: { () -> Void in
      self.imageView.transform = CGAffineTransformIdentity
    })
  }
}
  
/// 显示Alert警示框
///
/// - title:   显示标题，可选
/// - message: 警示语，可选
/// - okTitle: 按钮标题，可选
/// - onOk:    点击按钮的回调，可选
func showAlert(title: String?, message: String?, okTitle: String?, onOk: (() -> Void)?) {
  if #available(iOS 8.0, *) {
    let alert = UIAlertController(title: title,
      message: message,
      preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: okTitle,
      style: .Default,
      handler: { (acton) -> Void in
        // 传为可空处理一下
        if let okCallback = onOk {
          okCallback()
        }
    }));
    self.presentViewController(alert, animated: true, completion: nil)
  } else {
    UIAlertView(title: title,
      message: message,
      delegate: nil,
      cancelButtonTitle: okTitle).show()
  }
}
}

