//
//  NewsCell.swift
//  TableViewDemo
//
//  Created by huangyibiao on 15/9/13.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import UIKit

/// The cell to show news.
///
/// - Note:
/// - Blog: http://www.hybblog.com/
/// - Email: huangyibiao520@163.com
/// - Github: https://github.com/632840804/
/// - 微博：JackyHuang标哥
class NewsCell: UITableViewCell {
  /// The label to show the title of a news.
  var titleLabel: UILabel!
  
  /// The label to show the description of a news.
  var summaryLabel: UILabel!
  
  /// The label to show the author of a news.
  var authorLabel: UILabel!
  
  /// The data source representing a news.
  var newsModel: NewsModel?
  
  //
  // MARK: Constructer
  //
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    let screenWidth = UIScreen.mainScreen().bounds.width
    
    self.titleLabel = UILabel(frame: CGRectMake(10, 10, screenWidth - 20, 20))
    self.contentView.addSubview(self.titleLabel)
    
    self.summaryLabel = UILabel(frame: CGRectMake(10, 40, screenWidth - 20, 60))
    self.contentView.addSubview(self.summaryLabel)
    
    self.authorLabel = UILabel(frame: CGRectMake(10, 110, screenWidth - 20, 20))
    self.contentView.addSubview(self.authorLabel)
    self.authorLabel.textAlignment = NSTextAlignment.Right
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  //
  // MARK: Public
  func configCell(WithNewsModel newsModel: NewsModel?) {
    self.newsModel = newsModel
    
    if let title = newsModel?.title {
      self.titleLabel.text = title
    }
    
    if let summary = newsModel?.summary {
      self.summaryLabel.text = summary
    }
    
    self.authorLabel.text = newsModel?.author
  }
}