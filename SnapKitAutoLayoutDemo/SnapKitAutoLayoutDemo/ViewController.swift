//
//  ViewController.swift
//  SnapKitAutoLayoutDemo
//
//  Created by huangyibiao on 15/9/15.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import UIKit
// iOS9.0之后才支持将Pod导入的Framework module化，也就是说布局版本只能设置为>=9.0的版本，
// 才能直接使用import SnapKit导入源代码。所以这种方式是不可行的，支持的版本至少要达到8.0
// 这里不研究如何配置swift的pod，如需要了解，请查询相关文章
import SnapKit

/// 学习SnapKit纯代码自动布局
/// 环境:Xcode7-beta
/// Swift2.0
class ViewController: UIViewController {
  var scrollView = UIScrollView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // MARK: 注意事项
    // 添加约束之前，必须先将视图放到父视图中
    self.view.addSubview(scrollView)
    
    // 将scrollView占满self.view
    scrollView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self.view)
    }
    
    let screenWidth = UIScreen.mainScreen().bounds.width
    
    // 放一个按钮
    let scrollToBottomButton = UIButton(type: UIButtonType.Custom)
    scrollToBottomButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    scrollToBottomButton.backgroundColor = UIColor.redColor()
    scrollToBottomButton.setTitle("滚动到底部", forState: UIControlState.Normal)
    scrollView.addSubview(scrollToBottomButton)
    scrollToBottomButton.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(10)
      // 注意不能使right=-10，因为对于ScrollView来说，right是无边际的，此时参考self.view的
      make.right.equalTo(self.view.snp_right).offset(-10)
      //      make.right.equalTo(-10)
      make.top.equalTo(10)
      make.height.equalTo(40)
    }
    scrollToBottomButton.addTarget(self, action: "onScrollToBottomButtonHandler:",
      forControlEvents: UIControlEvents.TouchUpInside)
    
    // 放一个居中的视图
    let centerView = UIView()
    centerView.backgroundColor = UIColor.redColor()
    scrollView.addSubview(centerView)
    centerView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(scrollToBottomButton.snp_bottom).offset(30)
      make.centerX.equalTo(self.view)
      make.width.equalTo(screenWidth - 20)
      make.height.equalTo(60)
    }
    
    // 将三个Label水平平分
    let label1 = UILabel()
    label1.text = "标题1"
    label1.backgroundColor = UIColor.greenColor()
    scrollView.addSubview(label1)
    
    let label2 = UILabel()
    label2.text = "标题2"
    label2.backgroundColor = UIColor.yellowColor()
    scrollView.addSubview(label2)
    
    let label3 = UILabel()
    label3.text = "标题3"
    label3.backgroundColor = UIColor.blueColor()
    scrollView.addSubview(label3)
    
    // 间隔都为10
    label1.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(10)
      make.width.equalTo((screenWidth - 40) / 3 )
      make.top.equalTo(centerView.snp_bottom).offset(30)
      make.height.equalTo(40)
    }
    
    label2.snp_makeConstraints { (make) -> Void in
      make.width.top.height.equalTo(label1)
      make.left.equalTo(label1.snp_right).offset(10)
    }
    
    label3.snp_makeConstraints { (make) -> Void in
      make.width.top.height.equalTo(label1)
      make.left.equalTo(label2.snp_right).offset(10)
    }
    
    // 看看通过循环创建
    var preLabel: UILabel?
    for _ in 1...10 {
      let label = UILabel()
      label.backgroundColor = UIColor.greenColor()
      label.textColor = UIColor.yellowColor()
      label.numberOfLines = 0
      label.text = self.labelString()
      scrollView.addSubview(label)
      
      // 添加约束
      label.snp_makeConstraints(closure: { (make) -> Void in
        make.left.equalTo(10)
        make.width.equalTo(screenWidth - 20)
        
        if let previousLabel = preLabel {
          make.top.equalTo(previousLabel.snp_bottom).offset(30)
        } else {
          make.top.equalTo(label1.snp_bottom).offset(30)
        }
      })
      
      preLabel = label
    }
    
    // 放一个回到顶部按钮
    let scrollToTopButton = UIButton(type: UIButtonType.Custom)
    scrollToTopButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    scrollToTopButton.backgroundColor = UIColor.redColor()
    scrollToTopButton.setTitle("滚动到顶部", forState: UIControlState.Normal)
    scrollView.addSubview(scrollToTopButton)
    scrollToTopButton.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(10)
      // 注意不能使right=-10，因为对于ScrollView来说，right是无边际的，此时参考self.view的
      make.right.equalTo(self.view.snp_right).offset(-10)
      //      make.right.equalTo(-10)
      make.top.equalTo(preLabel!.snp_bottom).offset(40)
      make.height.equalTo(40)
    }
    scrollToTopButton.addTarget(self, action: "onScrollToTopButtonHandler:",
      forControlEvents: UIControlEvents.TouchUpInside)
    
    // 到最后一项的时候，需要让ScrollView的contentSize随内容而变化
    scrollView.snp_updateConstraints(closure: { (make) -> Void in
      make.bottom.equalTo(scrollToTopButton.snp_bottom).offset(30)
    })
  }
  
  // MARK: Button Event Handlers
  func onScrollToBottomButtonHandler(sender: UIButton) {
    UIView.animateWithDuration(0.4) { () -> Void in
      self.scrollView.setContentOffset(
        CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.frame.height),
        animated: true)
    }
  }
  
  func onScrollToTopButtonHandler(sender: UIButton) {
    UIView.animateWithDuration(0.4) { () -> Void in
      self.scrollView.setContentOffset(CGPointMake(0, -64), animated: true)
    }
  }

  
  // MARK: Private
  func labelString() ->String {
    let string = "本项目只是一个简单的小项目，旨在提高swift2.0的基本功。学完该项目，您将会与作者一起掌握到以下知识点：如何使用MARK对类API划分成不同的区域，以便快速定位找到对应的API；如何使用半包反向传值;如何写controller的convience init构造API学会UIAlertView和UIAlertController的使用;数据模型属性更简单声明;如何添加注释，以支持option+点击来查看API";
    
    return string
  }
}
