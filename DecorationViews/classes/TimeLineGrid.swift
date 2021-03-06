//
//  TimeLineGrid.swift
//  DecorationViews
//
//  Created by Hellen Soloviy on 8/18/17.
//  Copyright © 2017 Lemberg Solutions Limited. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class TimeLineGrid: UICollectionReusableView {
  
  var date: Date = Date()
  var timeLabel: UILabel = UILabel()
  var line: UIView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    line = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 1))
    line.backgroundColor = #colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 1)
    
    timeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: frame.height))
//    timeLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    timeLabel.font = UIFont.systemFont(ofSize: 11)
    timeLabel.textAlignment = .right
    timeLabel.textColor = #colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 1)
    timeLabel.text = "00:00"
    
//    self.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    self.addSubview(timeLabel)
    self.addSubview(line)
    
    let timeLabelWidth = 40
    
    self.line.snp.makeConstraints { (make) -> Void in
      make.width.equalTo(bounds.width - CGFloat(timeLabelWidth))
      make.leading.equalTo(timeLabelWidth)

      make.height.equalTo(0.5)
      make.centerY.equalToSuperview()
    }

    self.timeLabel.snp.makeConstraints { (make) -> Void in
      make.width.equalTo(timeLabelWidth - 4)
      make.height.equalToSuperview()
      make.centerY.equalToSuperview()
      make.leading.equalTo(0)
      
    }
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
