//
//  NewsModel.swift
//  TableViewDemo
//
//  Created by huangyibiao on 15/9/13.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation

/// The model of a news
///
/// - Note:
/// - Blog: http://www.hybblog.com/
/// - Email: huangyibiao520@163.com
/// - Github: https://github.com/632840804/
/// - 微博：JackyHuang标哥
class NewsModel: NSObject {
  /// The news' title
  var title = ""
  
  /// The description of a news.
  var summary = ""
  
  /// The author of a news, default is now.
  var author = "huangyibiao"
}